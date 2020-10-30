# 0-DB : the low level storage primitive

![](0db_head.png)

This primitive allows a user to reserve some storage on a node. The storage is exposed through [0-DB](https://github.com/Threefoldtech/0-DB), a low level key-value store that uses the RESP (redis) protocol.

0-DB is responsible to get the best write and read speed out of the HDD or SSD exposed underneath.

When a user reserves a 0-DB namespace, a portion of a disk is reserved for the user. This portion of disk is called a namespace. A namespace is protected by a password and has a certain size.

## Reservation definition

Here is the schema used to define a 0-DB namespace reservation:

- **Size**: The size of the namespace in GiB.
- **Mode**: 0-DB support different running mode. Check the 0-DB repository for more information about the possible running mode: https://github.com/Threefoldtech/0-DB#running-modes. Valid values for this fields are `seq` and `user`.
- **Password**: The password of the namespace. When creating the workload, you need to encrypt this value with the public key of the node.
- **DiskType**: The type of disk to use. value could be `HDD` or `SSD`.
- **Public**: Whether this 0-DB namespace should be publicly accessible.
- **pool_id**: The capacity pool ID to use to provision the workload.

## Network consideration

0-DB server is running on Zero-OS node and exposed on the Zero-OS nodes over public IPv6 addresses. The address of a specific 0-DB remains constant over time. This means even in the event a node reboots, the 0-DB will automatically start and have the same IP address.

## Useful links and extra documentation

If you want to dive in more about 0-DB itself, head to the official repository: [0-DB](https://github.com/Threefoldtech/0-DB).

## Example

```python
zos = j.sals.zos.get()

pool = zos.pools.get(12)

# find some node that have 10 GiB of SSD disks
nodes = zos.nodes_finder.nodes_search(sru=10)

# pick a node available in the chosen pool
node_id = None
for node in nodes:
     if node.node_id in pool.node_ids:
          node_id = node.node_id
          break

# create a 0-DB namespace workload of 10 GiB on a SSD disk.
zdb = zos.zdb.create(
 node_id=node_id,
 size=10,
 mode='seq',
 password='supersecret',
 pool_id=pool.pool_id,
 disk_type="SSD")

# deploy the workload and retrieve its ID
id = zos.workloads.deploy(zdb)

# inspect the result of the reservation provisioning
time.sleep(10)
zdb = zos.workloads.get(id)
result = zdb.info.result

print("provisioning result")
print(result) # show the result of the reservation
{'Namespace': '60-3', 'IPs': ['2a02:1802:5e:1102:e85a:41ff:fedb:2c65'], 'Port': 9900}

# create a client to the 0-DB namespace and connect to it
zdb = j.clients.zdb.new(name='demo',
     addr="2a02:1802:5e:1102:e85a:41ff:fedb:2c65",
     port=9900,
     secret='supersecret',
     nsname='60-3',mode='seq')

id = zdb.set('Hello')
zdb.get(id)
```
