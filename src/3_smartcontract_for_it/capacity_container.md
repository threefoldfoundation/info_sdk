# Container

![](./img/containers_real.png)

This primitive allows a user to run its application into a container on a node.

## Reservation definition

Here is the schema used to define a container reservation:

- **NodeId**: the node ID on which to create the volume
- **Flist**: the URL of the [flist](#flist). This URL needs to be reachable by the node. This is usually a URL to https://hub.grid.tf/
- **Environment**: the environment variables to set inside the container. This is usually used to configure the application running in the container
- **SecretEnvironment**: it is the same as `Environment` but these values are encrypted
- **Entrypoint**: it is the program to start when the container is created
- **Interactive**: if set to true, coreX is started in the container and the value of `Entrypoint` is ignored. See [the coreX section](corex---the-0-os-container-process-manager) for more detail
- **Volumes**: this is where you define which volume to mount inside the container
  - **VolumeID**: the ID of the volume
  - **Mountpoint**: the path into the container filesystem where to mount the volume
- **Capacity**:
  - **CPU**: the amount of virtual CPU to allocate to the container
  - **Memory**: the amount memory in MiB to allocate to the container
  - **DiskSize**: the size in MiB of the root filesystem of the container
  - **DiskType**: the type of disk to use for the root filesystem of the container. Valid value are 'HHD' or 'SSD'.
- **NetworkConnection**: this is where you define the network of the container
  - **NetworkId**: the name of the network created using a [network](network.md) primitive
  - **Ipaddress**: net.IP: The IP address to give to the container
  - **PublicIp6**: if this is true, the container will have an extra network interface with a Public IPv6 address. This is useful when you want to expose service directly to the public internet and out of your private overlay network
- **Logs**: a redis backend where you can send stdout and stderr output

## Flist

More information about flist at [flist documentation](architecture_flist.md)

## CoreX - The 0-OS container process manager

When running a container, if you want an interactive way to use it, the easiest solution is enabling `CoreX`.

When CoreX runs in your container, you'll get web access to your container (`container-ip:7681`) via a web browser.
On this web page, you can track processes you run and attach them to get a remote console within your web browser.

It's like ssh over web page.

You can use `j.clients.corex` to start, stop, list etc. process on your Core X.

## Example using sdk

```python
zos = j.sal.zosv2

# create a reservation
r = zos.reservation_create()

# add container reservation into the reservation
zos.container.create(reservation=r,
                    node_id='2fi9ZZiBGW4G9pnrN656bMfW6x55RSoHDeMrd9pgSA8T', # one of the node_id s that is part of the network
                    network_name='<network_name>', # this assumes that this network is already provisioned on the node
                    ip_address='172.24.1.10', # part of ip_range you reserved for your network xxx.xxx.1.10
                    flist='https://hub.grid.tf/zaibon/zaibon-ubuntu-ssh-0.0.2.flist', # flist of the container you want to install,
                    disk_size=2048, # request a 2GiB of storage for the root disk for the container
                    disk_type='SSD' # use an SSD for the root disk of the container
                  # interactive=True,  # True only if corex_connect required, default false
                    env={"KEY":"VAL"},
                    entrypoint='/sbin/my_init') #

# define the expiration date
expiration = j.data.time.epoch + (10*60) # 10 minutes

# register the reservation
registered_reservation = zos.reservation_register(r, expiration)

# pay for the capacity reserved
wallet = j.clients.stellar.default
zos.billing.payout_farmers(wallet, registered_reservation)

# inspect the result of the reservation provisioning
time.sleep(5)
result = zos.reservation_result(registered_reservation.reservation_id)

print("provisioning result")
print(result)
{'Namespace': '60-3', 'IP': '2a02:1802:5e:1102:e85a:41ff:fedb:2c65', 'Port': 9900}
```
