# Container Volume

This primitive allows a user to reserve some storage from a disk of a node.

The volume can then be mounted into a container so applications can have a persistent storage space from their containers.

Since a volume is a primitive by itself, you can have a single volume mounted in multiple containers.

This allows a user to create/update an existing container while keeping all the data separated.

## Reservation definition

Here is the schema used to define a 0-DB namespace reservation:

- **NodeId**: the node ID on which to create the volume
- **Size**: the size of the volume in GiB
- **Type**: the type of disk to use. value can be `HDD` or `SSD`

## Example using sdk

```python
zos = j.sal.zosv2

# create a reservation
r = zos.reservation_create()

# find some nodes that have 10 GiB of SSD disks
nodes = zos.nodes_finder.nodes_search(sru=10)

# reserve a volume of 10 GiB on a SSD disk
volume = zos.volume.create(reservation=r,
                           node_id=nodes[0].node_id,
                           size=10,
                           type='SSD')

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
```
