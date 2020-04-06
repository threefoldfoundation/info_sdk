## Deploy a simple S3 dispersed storage archive solution

#### Requirements

In order to be able to deploy this example deployment you will have to have the following components activated
- the Jumpscale SDK, in the form of a local container with the SDK, or a grid based SDK container.  Getting started instuctions are [here](/grid/peer2peer_storage_compute/general/jumpscale_SDK) 
- if you use a locally installed container with the 3bot SDK you need to have the wireguard software installed.  Instructions to how to get his installed on your platform can be found [here](https://www.wireguard.com/install/)

After following these install instructions you should end up having a local, working jumpscale SDK installed.  You can work / connect to the installed SDK as described [here](/grid/peer2peer_storage_compute/general/jumpscale_SDK/SDK_getting_started.md)

### Overview
The design a simple S3 archive solution we need to follow a few simple steps:
- create (or identify and use) an overlay network that spans all of the nodes needed in the solution
- identify which nodes are involved in the archive for storage and which nodes are running the storage software
- create reservations on the storage nodes for low level storage.  Create and deploy zero-DB's
- collect information of how to access and use the low level storage devices to be passed on to the S3 storage software
- design the architecture, data and parity disk design
- deploy the S3 software in a container

#### Create overlay network of identity an previously deployed overlay network

Each overlay network is private and contains private IP addresses.  Each overlay network is deployed in such a way that is has no connection to the public (IPv4 or IPv6) network directly.  In order to work with such a network a tunnel needs to be created between the overlay network on the grid and your local network.  You can find instructions how to do that [here](/grid/peer2peer_storage_compute/use_cases/examples/jupyter/network/overlay_network.md)


#### Set up the capacity environment to find, reserve and configure

Make sure that your SDK points to the mainnet explorer for deploying this capacity example.  Also make sure you have an identity loaded.  The example code uses the default identity.  Multiple identities can be stored in the jumpscale SDK.  To check your available identities you can request the number of identities available for you by typing `j.tools.threebot.me` in the kosmos shell.



```python
from Jumpscale import j
import time

j.clients.explorer.default_addr_set('explorer.grid.tf')

# Which identities are available in you SDK
j.tools.threebot.me

# Make sure I have an identity (set default one for mainnet of testnet)
me = j.tools.threebot.me.default

# Load the zero-os sal and reate empty reservation method
zos = j.sal.zosv2
r = zos.reservation_create()
```

#### Setup your overlay network (skip this step if you have a network setup and available)

An overlay network creates a private peer2peer network over selected nodes.  In this notebook it is assumend you have created one by following this [notebook](https://github.com/threefoldfoundation/info_projectX/blob/development/code/jupyter/SDK_examples/network/overlay_network.ipynb)

#### Design the S3 simple storage solution

You have created a network in the network creation [notebook](https://github.com/threefoldfoundation/info_projectX/blob/development/code/jupyter/SDK_examples/network/overlay_network.ipynb) with the following details:
```
demo_ip_range="172.20.0.0/16"
demo_port=8030
demo_network_name="demo_network_name_01"
```

When you executed the reservation it also provided you with a data on order number, node ID and private network range on the node.  All the nodes in the network are connected peer2peer with a wireguard tunnel.  On these nodes we can now create a storage solution.  For this solution we will using some of these nodes as raw storage provider nodes and others as the storage application nodes.  Using the ouput of the network reservation notebook to describe the high level design of the storage solution:

| Nr.  |  Location | Node ID.   |  IPV4 network    | Function.  |
|--------|---|---|---|---|
|    1    | Salzburg  | 9kcLeTuseybGHGWw2YXvdu4kk2jZzyZCaCHV9t6Axqqx  | 172.20.15.0/24  | Storage sofware container, 10GB raw  |
|    2    | Salzburg  | 3h4TKp11bNWjb2UemgrVwayuPnYcs2M1bccXvi3jPR2Y  | 172.20.16.0/24  |  10GB raw |
|    3    | Salzburg  |  FUq4Sz7CdafZYV2qJmTe3Rs4U4fxtJFcnV6mPNgGbmRg | 172.20.17.0/24  |  10GB raw |
|    4    | Vienna  |  9LmpYPBhnrL9VrboNmycJoGfGDjuaMNGsGQKeqrUMSii | 172.20.28.0/24  |  10GB raw |
|    5    | Vienna  |  3FPB4fPoxw8WMHsqdLHamfXAdUrcRwdZY7hxsFQt3odL | 172.20.29.0/24  |  10GB raw |
|    6    | Vienna  |  CrgLXq3w2Pavr7XrVA7HweH6LJvLWnKPwUbttcNNgJX7 | 172.20.30.0/24  |  10GB raw |


#### Reserve and deploy the low level ZeroDB storage nodes

First let's deploy low level storage capacity manager (Zero BD, more info [here](https://github.com/threefoldtech/0-db)).  In the next piece of code we do the following:
- create some empty reservation and result structures
- select and set the node to container the S3 software
- select and load the nodes in a list to push them in the zero-DB reservation structure


```python
# load the zero-os sal
zos = j.sal.zosv2

day=24*60*60
hour=60*60

# Node:  5  ID:  9kcLeTuseybGHGWw2YXvdu4kk2jZzyZCaCHV9t6Axqqx  IPv4 address:  172.20.15.0/24
minio_node_id = '9kcLeTuseybGHGWw2YXvdu4kk2jZzyZCaCHV9t6Axqqx'
minio_node_ip = '172.20.15.16'
# ----------------------------------------------------------------------------------
reservation_network = zos.reservation_create()
reservation_zdbs = zos.reservation_create()
reservation_storage = zos.reservation_create()

rid_network=0
rid_zdbs=0
rid_storage=0

password = "supersecret"

# ----------------------------------------------------------------------------------
# Select and create a reservation for nodes to deploy a ZDB
# first find the node where to reserve 0-db namespaces.  Select all the salzburg nodes
# ----------------------------------------------------------------------------------

nodes_salzburg = zos.nodes_finder.nodes_search(farm_id=12775) # (IPv6 nodes)
nodes_vienna_1 = zos.nodes_finder.nodes_search(farm_id=82872) # (IPv6 nodes)

# ----------------------------------------------------------------------------------
# Definition of functional nodes
# ----------------------------------------------------------------------------------
nodes_all = nodes_salzburg[5:8] + nodes_vienna_1[5:8]

# ----------------------------------------------------------------------------------
# Create ZDB reservation for the selected nodes
# ----------------------------------------------------------------------------------
for node in nodes_all:
    zos.zdb.create(
        reservation=reservation_zdbs,
        node_id=node.node_id,
        size=10,
        mode='seq',
        password='supersecret',
        disk_type="SSD",
        public=False)
    
```

#### Prepare and deploy the S3 software container

The nodes that will run the storage solution needs some persistent storage.  This will create a reservation for a volume on the same node as the software runs and attached this as a volume to the container that will run the storage software.  For the reservation duration please set a period of time that allows for expermenting, in this case it is set for one day.  


```python
# Storage solution reservation time
nr_of_hours=24

# ----------------------------------------------------------------------------------
# Attach persistant storage to container - for storing metadata
# ----------------------------------------------------------------------------------  
volume = zos.volume.create(reservation_storage,minio_node_id,size=10,type='SSD')
volume_rid = zos.reservation_register(reservation_storage, j.data.time.epoch+(nr_of_hours*hour), identity=me)
results = zos.reservation_result(volume_rid)

# ----------------------------------------------------------------------------------
# Actuate the reservation for the ZDB's  The IP addresses are going to be selfassigned.
# ----------------------------------------------------------------------------------
expiration = j.data.time.epoch + (nr_of_hours*hour)

# register the reservation
rid_zdb = zos.reservation_register(reservation_zdbs, expiration, identity=me)
time.sleep(5)

results = zos.reservation_result(rid_zdb)
```

If you want to have a look at what is returned as results it will look similar to this
```
category = "ZDB"
    data_json = "{\n \"IP\": \"2a04:7700:1003:1:54f0:edff:fe87:2c48\",\n \"Namespace\": \"9012-4\",\n \"Port\": 9900\n}"
    epoch = "2020/03/25 07:38:33"
    message = ""
    signature = "db9ffc8b89702887575ae1c54481a916bafea6036ce85419ab95302756c3ca45955fd8961901d87ccb3f0a92eca31bc202106fe3d1d746e32d0b01017c0b220e"
    state = "OK"
    workload_id = "9012-4"

    category = "ZDB"
    data_json = "{\n \"IP\": \"2a02:16a8:1000:0:5c2f:ddff:fe5a:1a70\",\n \"Namespace\": \"9012-1\",\n \"Port\": 9900\n}"
    epoch = "2020/03/25 07:38:35"
    message = ""
    signature = "0cded492a91fc54c862a79a56b4e41372ee4a7bd298ba01b94134b63679f35856a697fae8d9aa53d3b9de3aeb324b3ddea034eadeea708df0bf8e3d30176540a"
    state = "OK"
    workload_id = "9012-1"

    category = "ZDB"
    data_json = "{\n \"IP\": \"2a02:16a8:1000:0:1083:59ff:fe38:ce71\",\n \"Namespace\": \"9012-2\",\n \"Port\": 9900\n}"
    epoch = "2020/03/25 07:38:38"
    message = ""
    signature = "caf5c78a314e4673abadf2a53a79e20939598ef9c4dab07cd461c82cc195c8df940b0d7bb05544c409e5a3e695220c432d2c31e2366f595d46f4141b106dbc09"
    state = "OK"
    workload_id = "9012-2"

    category = "ZDB"
    data_json = "{\n \"IP\": \"2003:d6:2f32:8500:dc78:d6ff:fe04:7368\",\n \"Namespace\": \"9012-7\",\n \"Port\": 9900\n}"
    epoch = "2020/03/25 07:38:40"
    message = ""
    signature = "8eca8bc3feff37997f0a1958ab9c7b563932c7c4fc05fab9c95a4d353fb79e12ea1b1f3e355a8d13c790edc5e4fabe139970346a0fccbc9c32f4da91a7f7f20f"
    state = "OK"
    workload_id = "9012-7"

    category = "ZDB"
    data_json = "{\n \"IP\": \"2a02:16a8:1000:0:fc7c:4aff:fec8:baf\",\n \"Namespace\": \"9012-3\",\n \"Port\": 9900\n}"
    epoch = "2020/03/25 07:38:43"
    message = ""
    signature = "707ac7ed6a3930175b12488857a08a67b5d64dbc431fa19d3ccc1cea097b6c6bbbaac3a54de19360ca405079123f5f3f089e8ea3623a83e561fad5137dfa1507"
    state = "OK"
    workload_id = "9012-3"

    category = "ZDB"
    data_json = "{\n \"IP\": \"2a04:7700:1003:1:acc0:2ff:fed3:1692\",\n \"Namespace\": \"9012-5\",\n \"Port\": 9900\n}"
    epoch = "2020/03/25 07:38:44"
    message = ""
    signature = "4023a55eaf26a02dddb61004334c5324d4f880d31327eec4ad0884c6a0b66eaeff4b5e0f14725953ac45074abe6c984f71e06f8e2b37d3a341e4fe9d7a7e500f"
    state = "OK"
    workload_id = "9012-5"

    category = "ZDB"
    data_json = "{\n \"IP\": \"2a04:7700:1003:1:ac9d:f3ff:fe6a:47a9\",\n \"Namespace\": \"9012-6\",\n \"Port\": 9900\n}"
    epoch = "2020/03/25 07:38:44"
    message = ""
    signature = "86992453291b9c6dbf19965248ecc23a55f1b0379546b2fa41aa7476fde84e15e63174a0f8ee9e2e622d7e3986ecd15e07cba81d98d5a54f8bdc722b1fe64705"
    state = "OK"
    workload_id = "9012-6"
    
   ```

With the low level zero-DB reservations done and stored the `results` variable (these storage managers will get an IPv4 address assigned from the local `/24` node network.  We need to store those addresses in `namespace_config` to pass it to the container running the storage software.


```python
# ----------------------------------------------------------------------------------
# Read the IP address of the 0-db namespaces after they are deployed
# we will need these IPs when creating the minio container
# ----------------------------------------------------------------------------------
namespace_config = []
for result in results:
    data = result.data_json
    cfg = f"{data['Namespace']}:{password}@[{data['IP']}]:{data['Port']}"
    namespace_config.append(cfg)
    
# All IP's for the zdb's are now known and stored in the namespace_config structure.
print(namespace_config)
```

```
['9012-4:supersecret@[2a04:7700:1003:1:54f0:edff:fe87:2c48]:9900', '9012-1:supersecret@[2a02:16a8:1000:0:5c2f:ddff:fe5a:1a70]:9900', '9012-2:supersecret@[2a02:16a8:1000:0:1083:59ff:fe38:ce71]:9900', '9012-7:supersecret@[2003:d6:2f32:8500:dc78:d6ff:fe04:7368]:9900', '9012-3:supersecret@[2a02:16a8:1000:0:fc7c:4aff:fec8:baf]:9900', '9012-5:supersecret@[2a04:7700:1003:1:acc0:2ff:fed3:1692]:9900', '9012-6:supersecret@[2a04:7700:1003:1:ac9d:f3ff:fe6a:47a9]:9900']
```

Last step is to design the redundacy policy for the storage solution.  We have 6 low level devices available (over 6 nodes, in 2 different datacenters and cities).  So we can build any of the following configurations:

| Option | data storage devices | parity storage devices | total devices  | overhead  |
|--------|---|---|---|---|
|  1      | 3  | 3  | 6  | 50%%  |
|  2      | 4  | 2  | 6  | 33% |
|  3      | 5  | 1  | 6  | 16%  |

Now in this example real efficiency of this solution is not achieved, in a real life deployment we would do something like this:

| Option | data storage devices | parity storage devices | total devices  | overhead  |
|--------|---|---|---|---|
|  4      | 16  | 4  | 20  | 20%  |

In that case it is highly unlikely that 4 distributed devices will fail at the same time, therefore this is a very robust storage solution


Here we choose to deploy scenario 2 with 4 data disks and 2 parity disks.


```python
# ----------------------------------------------------------------------------------
# With the low level disk managers done and the IP adresses discovered we can now build
# the reservation for the min.io S3 interface.
# ----------------------------------------------------------------------------------
reservation_minio = zos.reservation_create()

# Make sure to adjust the node_id and network name to the appropriate in copy / paste mode :-)
minio_container=zos.container.create(reservation=reservation_minio,
    node_id=minio_node_id,
    network_name=u_networkname,
    ip_address=minio_node_ip,
    flist='https://hub.grid.tf/azmy.3bot/minio.flist',
    interactive=False, 
    entrypoint='/bin/entrypoint',
    cpu=2,
    memory=2048,
    env={
        "SHARDS":','.join(namespace_config),
        "DATA":"4",
        "PARITY":"2",
        "ACCESS_KEY":"minio",
        "SECRET_KEY":"passwordpassword",
        })
```

With the definition of the S3 container done we now need to attached persistent storage on a volume to store metadata.


```python
# ----------------------------------------------------------------------------------
# Attach persistant storage to container - for storing metadata
# ----------------------------------------------------------------------------------  
zos.volume.attach_existing(
    container=minio_container,
    volume_id=f'{volume_rid}-{volume.workload_id}',
    mount_point='/data')
```

Last but not least, execute the resevation for the storage manager.


```python
# ----------------------------------------------------------------------------------
# Write reservation for min.io container in BCDB - end user interface
# ----------------------------------------------------------------------------------      
expiration = j.data.time.epoch + (nr_of_hours*hour)
# register the reservation
rid = zos.reservation_register(reservation_minio, expiration, identity=me)
time.sleep(5)

results = zos.reservation_result(rid)
```
