
# Prepare a 3Node.

![](./img/threenode_wide.png)

## Check your 3Node disk configuration

We strongly recommend you first check your node's disk configuration.

How a disk should look like for it to be picked up by Zero OS:

- No labels
- No partitions
- No filesystems

To erase a disk do the following

- boot the 3node using a linux distro (live usb) e.g. https://grml.org/download/

then do

```bash
for i in /dev/sd*; do parted -s $i mklabel msdos; dd if=/dev/zero of=$i bs=1M ; done
```

be very careful because this will erase all your disks,

## Check your 3Node network config.

- a 3Node needs to be connected to the internet (can be behind a NAT firewall) over a physical LAN connection (Ethernet connection).

## Minimal Hardware Requirements

- CPU at least 4 virtual cores
- at least 8 GB memory
- at least 512 GB SSD


