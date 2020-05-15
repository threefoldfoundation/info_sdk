# 0-DB : the low level storage primitive

![](0db_head.png)

This primitive allows a user to reserve some storage on a node. The storage is exposed through [0-DB](https://github.com/threefoldtech/0-DB), a low level key-value store that uses the RESP (redis) protocol.

0-DB is responsible to get the best write and read speed out of the disk or SSD exposed underneath.

When a user reserves a 0-DB namespace, a portion of a disk is reserved for the user. This portion of disk is called a namespace. A namespace is protected by a password and has a certain size.

## Reservation definition

Here is the schema used to define a 0-DB namespace reservation:

- **NodeId**: the node ID on which to create the 0-DB namespace
- **Size**: the size of the namespace in GiB
- **Mode**: 0-DB support different running mode. Check the 0-DB repository for more information about the possible running mode: https://github.com/threefoldtech/0-db#running-modes
- **Password**: the password of the namespace. When creating the reservation, you need to encrypt this value with the public key of the node
- **DiskType**: the type of disk to use. value can be `HDD` or `SSD`

## Network consideration

0-DB server is running on 0-OS node and exposed on the 0-OS nodes over public IPv6 addresses. The address of a specific 0-DB remains constant over time. This means even in the event a node reboots, the 0-DB will automatically start and have the same IP address.

## Useful links and extra documentation

If you want to dive in more about 0-DB itself, head to the official repository: [0-DB](https://github.com/threefoldtech/0-DB)

## Example

```python
zos = j.sal.zosv2

# find some node that have 10 GiB of SSD disks
nodes = zos.nodes_finder.nodes_search(sru=10)

# create a reservation
r = zos.reservation_create()

# reserve a 0-DB namespace of 10 GiB on a SSD disk.
zos.zdb.create(
    reservation=r,
    node_id=nodes[0].node_id,
    size=10,
    mode='seq',
    password='supersecret',
    disk_type="SSD")

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
print(result) # show the result of the reservation
{'Namespace': '60-3', 'IP': '2a02:1802:5e:1102:e85a:41ff:fedb:2c65', 'Port': 9900}

# create a client to the 0-DB namespace and connect to it
zdb = j.clients.zdb.new(name='demo',
                  addr="2a02:1802:5e:1102:e85a:41ff:fedb:2c65",
                  port=9900,
                  secret='supersecret',
                  nsname='60-3',mode='seq')

id = zdb.set('Hello')
zdb.get(id)
```