
# Ultra efficient virtual filesystem for Zero-OS

![](./img/vfs_intro2.png)


## Flist architecture

Have you ever seen an archive with only a few interesting files inside ? What a disappointment when you see this archive is 4 GB large and you only need 4 files of 2 MB inside. You'll need to download the full archive, store it somewhere to extract only what you need. Time and bandwidth wasted.

You want to start a Docker container and the base image you want to use is 2 GB. What do you need to do before being able to use your container ? Waiting to get the 2 GB downloaded.

You're in Europe with decent Internet connections? For you this is probably a few minutes to wait, time to grab a cup of coffee (or a can of Cola), and you're done. If you're somewhere, like in Egypt, this is going to take half of your day with a lot of complaints around you because you're souping up all the available bandwidth of the office.

It would be a lot more efficient if you could only download the files you actually want and not the full blob (archive, image, whatever...).

### Enter the flist (Files List) format and concept

#### Metadata and Data

The main idea is splitting metadata and data. Metadata is referential information about everything you need to know about the contents of the archive, but without the payload. The payload is the content of the referred files.

If you could only download the metadata (which is really small) and download only the payload you want, you could dramatically improve bandwidth usage and download time, as mostly, you only need a small part of the archive.

Imagine, you store the payload of your files somewhere and only keep the metadata somewhere else. If you download the metadata of an archive, you'll know the contents (files list, names, permissions, files size, etc.). If you add extra information to explain how to reach payload, you have a lightweight archive which looks like a real archive but way smaller (it's the payload which are large usually).

That's it, a flist is exactly that metadata with references that point to where to get the payload itself. And that's how you can get a lot of benefit about storage and bandwidth.

#### But how does it work ?

One word: CAS (or more words: Content Addressed Storage). We store metadata and data in two ways. Data is stored in a 0-db somewhere. We split files into chunks, and then we save each chunk (content) and its hash (address) into the database (storage).

The flist itself is the Metadata. It's a database that contains a list of directories and files, all their information (name, size, permissions, ...) and the list of chunk addresses (the list of hashes we can use to query the database).

We store flist files into our [<< hub >>](https://hub.grid.tf) which is just an HTTP server serving static files. For example, you can see the file ubuntu:18.04 which is mostly the same as ubuntu:18.04 Docker Image, but the flist is 3.16 MB large. By downloading this, you have enough information to know everything in the archive.

With some tools (like 0-fs, explained later), you can even mount that flist and use it like a real directory.


## More info

- see [container virtual filesystem details](container_vfs_details.md)
- see [how to build and upload flist](flist.md)
