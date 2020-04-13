
# Architecture container boot

<!--
#TODO #48: container boot need to describe how it works
-->

## Flist architecture
Have you ever seen an archive with only a few interesting files inside ? What a disappointment when you see this archive is 4 GB large and you only need 4 files of 2 MB inside. You'll need to download the full archive, store it somewhere to extract only what you need. Time and bandwidth wasted.

You want to start a Docker container and the base image you want to use is 2 GB. What do you need to do before being able to use your container ? Waiting to get the 2 GB downloaded.

You're in Europe with decent Internet connections? For you this is probably a few minutes to wait, time to grab a cup of coffee (or a can of Cola), and you're done. If you're somewhere, like in Egypt, this is going to take half of your day with a lot of complaints around you because you're souping up all the available bandwidth of the office.

It would be a lot more efficient if you could only download the files you actually want and not the full blob (archive, image, whatever...).

### Enter the flist (Files List) format and concept.

#### Metadata and Data
The main idea is splitting metadata and data. Metadata is referential information about everything you need to know about the contents of the archive, but without the payload. The payload is the content of the referred files.

If you could only download the metadata (which is really small) and download only the payload you want, you could dramatically improve bandwidth usage and download time, as mostly, you only need a small part of the archive.

Imagine, you store the payload of your files somewhere and only keep the metadata somewhere else. If you download the metadata of an archive, you'll know the contents (files list, names, permissions, files size, etc.). If you add extra information to explain how to reach payload, you have a lightweight archive which looks like a real archive but way smaller (it's the payload which are large usually).

That's it, a flist is exactly that metadata with references that point to where to get the payload itself. And that's how you can get a lot of benefit about storage and bandwidth.

#### But how does it work ?
One word: CAS (or more words: Content Addressed Storage). We store metadata and data in two ways. Data is stored in a 0-db somewhere. We split files into chunks, and then we save each chunk (content) and it's hash (address) into the database (storage).

The flist itself is the Metadata. It's a database that contains a list of directories and files, all their information (name, size, permissions, ...) and the list of chunk addresses (the list of hashes we can use to query the database).

We store flist files into our [<< hub >>](https://hub.grid.tf) which is just an HTTP server serving static files. For example, you can see the file ubuntu:18.04 which is mostly the same as ubuntu:18.04 Docker Image, but the flist is 3.16 MB large. By downloading this, you have enough information to know everything in the archive.

With some tools (like 0-fs, explained later), you can even mount that flist and use it like a real directory.

#### And how does that work under the hood?
The base level of flist contents is an SQLite3 database. This database file is archived inside a tar archive, compressed using gzip. So it's a gzip-compressed SQLite database.
Why a tar archive ? Well, we envision that we'll add features to 0-fs, and it might be that we need more than just a compressed database, but also some files that could describe more than what's there now. Remember, a flist is 'just' an elaborate description of the content, so we can easily add these 'descriptions' as files to the tar archive.

The database aims to work like a key-value store. We chose sqlite3 for platform compatibility and speed. It's not the best but it's easy to use and widely available... and... Open-Source.

You'll find 2 tables in that database: entries and metadata.

##### Entries
This is the main table, which works as a key-value store. The hashes are the key, values are a binary blob.

A Key can be a hash of two differents things: an ACL (8 bytes) or a directory (16 bytes):

ACLs are text encoded strings describing user, group and file permissions. We hash the contents (this is the key) and store it in the database, that way, we can dedupe permissions. In terms of content-addressed storage, dedupe means that key references always the same file, alleviating the need to store it every time again. As there are a lot of identical permissions, let's say for example: User: root, Group: root, Permission: 01755, that ACL needs to be stored only once.

Directories are capnp serialized binary objects that contain all information needed to describe the directory contents. The key used to store that blob is hash of the full path (eg: blake2b_16("/usr/share/man")).

A directory contains: full path, directory name, permissions, link to it's parent directory, eventual ACLS, modification and creation time, and obviously, a list of files it contains.

Each file entry on that list represents a kind of inode, containing:

- File name
- File size
- Type of file (regular, symlink, block, character, socket, ...)
- Extra information based on the type (directory target, symlink target, ...)
- ACL hash
- Creation and modification time
- List of chunk hashes to reference the payload

Each file is cut in chunks (fixed size of 512KB right now), each chunk is compressed with snappy then encrypted using an xxtea algorithm. The encryption key is the blake2 hash of the chunk. This is quite useful for security and consistency since we can ensure that the payload is not modified after the flist is created, while encryption is needed to avoid readable data on the backend disk.

##### Metadata
This table contains extra data (not mandatory to make a working flist) to improve the description of the flist.

Flists are designed to be used as Container or VM root filesystems, where added metadata can describe all sorts of things, like which ports need to be opened/forwarded to use the container, what volumes to mount, specify the default backend from where to get the data, location, credentials, etc. There can also be extra metadata like licenses or readme's attached to the flist to provide useful information.

#### You can get more information about metadata here.

Zero-FS (0-fs)
We created a small tool called 0-fs, which uses the power of of the flist metadata and lets you mount this flist on your local machine to navigate inside directories, etc. With all the files inside, using a FUSE layer.

As soon as you have the flist mounted, you can see the full directory tree, and walk around it as you see fit. The FUSE layer exposes the flist as a regular directory tree, where files are put in place the moment you try to access them. In other words, every time you want to read a file, or modify it, 0-fs will download it, or better, download all the chunks that compose the file to a writable cache layer, so that the data becomes available too, not only the metadata. You only download on-the-fly what you need, which reduces dramatically the bandwidth requirement.

Obviously, this kind of situation adds some latency when you access the file the first time, but as soon as chunks and files are in the local cache, you don't need to re-download them next time. And our system is dedupe (CAS) by design because we store chunks by their hash, so if multiple archives point to the same files, you only need to download and store it once ! Also, the chunks exist only once in the backend too.

#### Early version
Earlier versions of flist were plain text format listing files, metadata and chunks using plain text and pipe as a delimiter, but we moved to a more complex but easier to manipulate format, with a higher-level programming interface.

Versions of 0-fs had RocksDB incorporated as key-value store, but that library was very difficult to integrate and maintain, that we opted for SQLite as backend.

Also, we reduced some hash lengths, like for permissions, to further reduce the flist sizes themselves.

Although size and performance results are more than satisfactory, the flist format is still subject to change. In fact, while the capnp serializing format is very effective, we feel we can optimize the inner workings of 0-fs even further, we'll keep you posted on the progress.

### Conclusion
In short, 0-fs is without a doubt, the best thing since sliced bread, period.

Draw me like one of your french ASCII
```
  flist archive                                   0-db backend
+-------------------+                          +----------------+
| metadata file1    |                          | chunk1         |
|   - chunk1,2,3    |                          | chunk2         |
| metadata file2    |                          | chunk3         |
|   - chunk4,5      |                          | chunk4         |
| metadata file3    |                          | chunk5         |
|   - chunk1,5,6    |                          | chunk6         |
| ...               |                          | ...            |
+-------------------+                          +----------------+
                ||                                ||
              =======================================
                         0-fs fuse layer
     =========================================================
     ==                                                     == 
     == /vmlinuz                                            ==
     == /initrd.img                                         ==
     == /var/run                                            ==
     == /var/lock                                           ==
     == /var/lib/apt/extended_states                        ==
     == /var/lib/apt/lists/lock                             ==
     == /var/tmp                                            ==
     == /var/opt                                            ==
     == /var/mail                                           ==
     == /var                                                ==
     == /bin/bash                                           ==
     == /bin/cat                                            ==
     == /bin/chgrp                                          ==
     == /bin/chmod                                          ==
     == ...                                                 ==
     =========================================================
```    
## Convert docker image into flist

If you already have some docker images of your application, you can convert them directly into flist: https://hub.grid.tf/docker-convert