# Flist

In Zero-OS, `flist` is the format used to store containers images. This format is made to provide
a complete mountable remote filesystem but downloading only the files contents that you actually needs.

In practice, flist itself is a small database which contains metadata about files and directories and
file payload are stored on an remote database. You only need to download payload when you need it, this
dramatically reduce container boot time, bandwidth and disk overhead.

# Hub

We provide a public hub you can use to upload your own flist or filesystem directly and take
advantages of flist out-of-box on Zero-OS. You can convert an existing docker image the same way.

Public hub: [hub.grid.tf](https://hub.grid.tf)

If you want to experiment the hub and features, you can use the [playground hub](https://playground.hub.grid.tf).
This hub can be reset anytime, don't put sensitive or production code there.

# Build your own flist using 3sdk

### we using zflist binary in [0-flist](https://github.com/threefoldtech/0-flist/tree/development-v2)
 
to install it using kosmos
 ```
 j.builders.storage.zflist.install(reset=True)
 ```
 
## create new flist:
### create new flist then put file from local then commit it
```python
new_flist = j.data.flist.new() 
new_flist.put("/sandbox/code/github/test.py","/") 
new_flist.commit("/sandbox/code/app.flist") 
#delete everything in temporary-point
new_flist.close()
```

## open flist and edit on it:
### open flist , put dir from local , commit it
```python
new_flist = j.data.flist.open("/tmp/app.flist") 
new_flist.put_dir ("/tmp/app","/") 
# list all things in flist
new_flist.list_all()
new_flist.commit("/sandbox/code/app2.flist") 
#delete everything in temporary-point
new_flist.close()
```


## upload flist to hub (Guest):
before upload to hub please export  ``ZFLIST_HUB_TOKEN`` on this [example](https://github.com/threefoldtech/0-flist/tree/development-v2#example)

```python
new_flist = j.data.flist.open("/tmp/app.flist") 
new_flist.put_dir ("/tmp/app","/") 
# list all things in flist
new_flist.list_all()
new_flist.commit("/sandbox/code/app2.flist") 
new_flist.upload("/sandbox/code/app2.flist")
```

Then check it at ```https://playground.hub.grid.tf/guest```


## Command line tool

If you want to use command line tools, you can use [0-flist](https://github.com/threefoldtech/0-flist/tree/development-v2)

Here is a simple example how to upload a complete directory:

```
export ZFLIST_MNT=/tmp/zflistmnt
export ZFLIST_BACKEND='{"host": "hub.grid.tf", "port": 9980}'
export ZFLIST_HUB_TOKEN=eyJhbGciOiJFUzM4NCIsInR5cCI6IkpXVC....

zflist init
zflist putdir /mnt/ubuntu-18.04 /
zflist commit /tmp/ubuntu-18.04.flist
zflist hub upload /tmp/ubuntu-18.04.flist
```

Note: token is itsyou.online API key, you can't use 3Bot login for now.
An open issue to allow it is in progress at [threefoldtech/0-hub/issues/28](https://github.com/threefoldtech/0-hub/issues/28)


## Upload an image

The easiest way to upload your image to the hub is building a `.tar.gz` archive of your files/directories
(the root directory of your container) and upload it to the hub. The hub will itself convert it to an flist
you can use directly on any Zero-OS container.

## Metadata

Hub include a way to add some metadata (eg: a readme) available through the hub directly. Just add a file
called `.README.md` (or `.README`) on the root directory of your archive, this file will be used as
readme. You can use this readme to add documentation about your flist if other people want to use it.

<!-- Add link to example when this will be available on the production hub -->

## GitHub Action

If you want to use the hub as default target when you work on your project, you can build an flist
easily via GitHub Action using [publish-flist action](https://github.com/threefoldtech/publish-flist)

# Internals

You can find a lot more information on how flist works internally on the Zero-OS FreeFlowPages post: 
[freeflowpages.com/s/zero-os](https://freeflowpages.com/s/zero-os/?contentId=9396)
