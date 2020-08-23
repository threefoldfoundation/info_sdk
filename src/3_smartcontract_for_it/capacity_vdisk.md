# Container Volume

This primitive allows a user to reserve some storage from a disk of a node.

The volume could then be mounted into a container so applications could have a persistent storage space from their containers.

Since a volume is a primitive by itself, you could have a single volume mounted in multiple containers.

This allows a user to create/update an existing container while keeping all the data separated.

## Reservation definition

Here is the schema used to define a 0-DB namespace reservation:

* **NodeId**: the node ID on which to create the volume
* **Size**: the size of the volume in GiB
* **Type**: the type of disk to use. value could be `HDD` or `SSD`
* **pool_id**: the capacity pool ID to use to provision the workload

## Example using sdk

``` python
zos = j.sals.zos

# find some nodes that have 10 GiB of SSD disks
nodes = zos.nodes_finder.nodes_search(sru=10)

# reserve a volume of 10 GiB on a SSD disk
volume = zos.volume.create(reservation=r,
       node_id=nodes[0].node_id,
       size=10,
       type='SSD')

# deploy the workload
id = zos.workloads.deploy(volume)

# inspect the result of the reservation provisioning
time.sleep(10)
zdb = zos.workloads.get(id)

print("provisioning result")
print(zdb.info.result)
```
