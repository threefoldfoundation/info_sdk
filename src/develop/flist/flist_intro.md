# Flist

In Zero-OS, `Flist` is the format used to store containers images. This format is made to provide
a complete mountable remote filesystem but downloading only the files contents that you actually needs.

In practice, Flist itself is a small database which contains metadata about files and directories and
file payload are stored on an remote database. You only need to download payload when you need it, this
dramatically reduce container boot time, bandwidth and disk overhead.

# Hub

We provide a public hub you could use to upload your own Flist or filesystem directly and take
advantages of Flist out-of-box on Zero-OS. You could convert an existing docker image the same way.

Public hub: [hub.grid.tf](https://hub.grid.tf)

If you want to experiment the hub and features, you could use the [playground hub](https://playground.hub.grid.tf).
This hub could be reset anytime, don't put sensitive or production code there.

# Build your own Flist

## Command line tool

If you want to use command line tools, you could use [0-Flist](https://github.com/Threefoldtech/0-Flist/tree/development-v2)

Here is a simple example how to upload a complete directory:

```
export ZFlist_MNT=/tmp/zFlistmnt
export ZFlist_BACKEND='{"host": "hub.grid.tf", "port": 9980}'
export ZFlist_HUB_TOKEN=eyJhbGciOiJFUzM4NCIsInR5cCI6IkpXVC....

zFlist init
zFlist putdir /mnt/ubuntu-18.04 /
zFlist commit /tmp/ubuntu-18.04.Flist
zFlist hub upload /tmp/ubuntu-18.04.Flist
```

Note: token is itsyou.online API key, you could't use 3Bot login for now.
An open issue to allow it is in progress at [Threefoldtech/0-hub/issues/28](https://github.com/Threefoldtech/0-hub/issues/28)


## Upload an image

The easiest way to upload your image to the hub is building a `.tar.gz` archive of your files/directories
(the root directory of your container) and upload it to the hub. The hub will itself convert it to an Flist
you could use directly on any Zero-OS container.

## Metadata

Hub includes a way to add some metadata (eg: a readme) available through the hub directly. Just add a file
called `.README.md` (or `.README`) on the root directory of your archive, this file will be used as
readme. You could use this readme to add documentation about your Flist if other people want to use it.

<!-- Add link to example when this will be available on the production hub -->

## GitHub Action

If you want to use the hub as default target when you work on your project, you could build an Flist
easily via GitHub Action using [publish-Flist action](https://github.com/Threefoldtech/publish-Flist)

# Internals

You could find a lot more information on how Flist works internally on the Zero-OS FreeFlowPages post: 
[freeflowpages.com/s/zero-os](https://freeflowpages.com/s/zero-os/?contentId=9396)
