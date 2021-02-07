## Deploy a simple S3 dispersed storage archive solution

#### Requirements

Please check the [general requirements](code)

### Overview

The aim is to create a simple S3 archive solution by following a few steps:

* Create and pay for capacity pools in which you reserve the capacity that your workloads will run on.
* Create (or identify and use) an overlay network workload that spans all of the nodes needed in the solution (through the capacity pools).
* Identify which nodes are involved in the archive for storage and which nodes are running the storage software.
* Create workloads on the storage nodes for low-level storage. Create and deploy zero-DB's.
* Collect information of how to access and use the low-level storage devices to be passed on to the S3 storage software.
* Design the architecture, data and parity disk design.
* Deploy the S3 software in a container.

#### Create an overlay network or use the identity of a previously deployed overlay network

Each overlay network is private and contains private IP addresses. Each overlay network is deployed in such a way that is has no connection to the public (IPv4 or IPv6) network directly. In order to work with such a network a tunnel needs to be created between the overlay network on the grid and your local network. You could find instructions how to create a network [here](code_network).

#### Design the S3 simple storage solution

You have created a network in the network creation [tutorial](code_network) with the following details:

``` python
demo_ip_range="172.20.0.0/16"
demo_port=8030
demo_network_name="demo_network_name_01"
```

When you deployed the network workload it also provided you with data on the order number, node ID and private network range on the node. All the nodes in the network are connected peer-to-peer with a wireguard tunnel. On these nodes we could now create a storage solution. For this solution we will using some of these nodes as raw storage provider nodes and others as the storage application nodes. Using the output of the network reservation notebook to describe the high-level design of the storage solution:

| Nr. | Location | Node ID. | IPV4 network | Function. |
|--------|---|---|---|---|
| 1 | Salzburg | 9kcLeTuseybGHGWw2YXvdu4kk2jZzyZCaCHV9t6Axqqx | 172.20.15.0/24 | Storage software container, 10GB raw |
| 2 | Salzburg | 3h4TKp11bNWjb2UemgrVwayuPnYcs2M1bccXvi3jPR2Y | 172.20.16.0/24 | 10GB raw |
| 3 | Salzburg | FUq4Sz7CdafZYV2qJmTe3Rs4U4fxtJFcnV6mPNgGbmRg | 172.20.17.0/24 | 10GB raw |
| 4 | Vienna | 9LmpYPBhnrL9VrboNmycJoGfGDjuaMNGsGQKeqrUMSii | 172.20.28.0/24 | 10GB raw |
| 5 | Vienna | 3FPB4fPoxw8WMHsqdLHamfXAdUrcRwdZY7hxsFQt3odL | 172.20.29.0/24 | 10GB raw |
| 6 | Vienna | CrgLXq3w2Pavr7XrVA7HweH6LJvLWnKPwUbttcNNgJX7 | 172.20.30.0/24 | 10GB raw |

#### Reserve and deploy the low level ZeroDB storage nodes

First let's deploy low-level storage capacity manager (Zero-DB, more info [here](https://github.com/Threefoldtech/0-DB)). In the next piece of code we do the following:

* Select and set the node to container the S3 software.
* Select and load the nodes in a list to push them in the zero-DB reservation structure.

``` python
# load the zero-os sal
zos = j.sals.zos.get()

# Node: 5 ID: 9kcLeTuseybGHGWw2YXvdu4kk2jZzyZCaCHV9t6Axqqx IPv4 address: 172.20.15.0/24
minio_node_id = '9kcLeTuseybGHGWw2YXvdu4kk2jZzyZCaCHV9t6Axqqx'
minio_node_ip = '172.20.15.16'

# use the pool
pool = zos.pools.get(payment_detail.reservation_id)

# ----------------------------------------------------------------------------------
password = "supersecret"

# ----------------------------------------------------------------------------------
# Select and create a reservation for nodes to deploy a ZDB
# first find the node where to reserve 0-DB namespaces. Select all the salzburg nodes
# ----------------------------------------------------------------------------------

results = []
for node in pool.node_ids:
 w_zdb = zos.zdb.create(
  node_id=node.node_id,
  size=10,
  mode=0, # seq
  password=password,
  pool_id=pool.pool_id,
  disk_type=1,#SSD=1, HDD=0
  public=False)
 id = zos.workloads.deploy(w_zdb)

 result_workload = zos.workloads.get(id)

 results.append(result_workload)
```

#### Prepare and deploy the S3 software container

The nodes that will run the storage solution needs some persistent storage. This will create a reservation for a volume on the same node as the software runs and attached this as a volume to the container that will run the storage software. For the reservation duration please set a period of time that allows for experimenting, in this case it is set for one day.

``` python

# ----------------------------------------------------------------------------------
# Create a persistent storage volume for storing metadata.
# ----------------------------------------------------------------------------------
volume = zos.volume.create(minio_node_id, pool.pool_id,size=10,type='SSD')
volume_id = zos.workloads.deploy(volume)
volume = zos.workloads.get(volume_id)

```

With the low level zero-DB reservations done and stored the `results` variable. Each zdb result will have the IPv6 address of the instance and namespace name.

``` python
# ----------------------------------------------------------------------------------
# Read the IP address of the 0-DB namespaces after they are deployed.
# We will need these IPs when creating the minio container.
# ----------------------------------------------------------------------------------
namespace_config = []
for result in results:
 if result.category == 0: #0 corresponds to ZDB
  data = j.data.serializers.json.loads(result.data_json)
  if data.get("IP"):
   ip = data["IP"]
  elif data.get("IPs"):
   ip = data["IPs"][0]
  else:
   raise j.exceptions.RuntimeError("missing IP field in the 0-DB result")
  cfg = f"{data['Namespace']}:{password}@[{ip}]:{data['Port']}"
  namespace_config.append(cfg)

# All IP's for the zdb's are now known and stored in the namespace_config structure.
print(namespace_config)
```

``` 
['9012-4:supersecret@[2a04:7700:1003:1:54f0:edff:fe87:2c48]:9900', '9012-1:supersecret@[2a02:16a8:1000:0:5c2f:ddff:fe5a:1a70]:9900', '9012-2:supersecret@[2a02:16a8:1000:0:1083:59ff:fe38:ce71]:9900', '9012-7:supersecret@[2003:d6:2f32:8500:dc78:d6ff:fe04:7368]:9900', '9012-3:supersecret@[2a02:16a8:1000:0:fc7c:4aff:fec8:baf]:9900', '9012-5:supersecret@[2a04:7700:1003:1:acc0:2ff:fed3:1692]:9900', '9012-6:supersecret@[2a04:7700:1003:1:ac9d:f3ff:fe6a:47a9]:9900']
```

The last step is to design the redundancy policy for the storage solution. We have 6 low-level devices available (over 6 nodes, in 2 different data centers and cities). So we could build any of the following configurations:

| Option | data storage devices | parity storage devices | total devices | overhead |
|--------|---|---|---|---|
| 1  | 3 | 3 | 6 | 50%% |
| 2  | 4 | 2 | 6 | 33% |
| 3  | 5 | 1 | 6 | 16% |

Now in this example the real efficiency of this solution is not achieved, in a real-life deployment we would do something like this:

| Option | data storage devices | parity storage devices | total devices | overhead |
|--------|---|---|---|---|
| 4  | 16 | 4 | 20 | 20% |

In that case it is highly unlikely that 4 distributed devices will fail at the same time, therefore this is a very robust storage solution.

Here we choose to deploy scenario 2 with 4 data disks and 2 parity disks.

``` python
# ----------------------------------------------------------------------------------
# With the low level disk managers done and the IP adresses discovered we could now build
# the reservation for the min.io S3 interface.
# ----------------------------------------------------------------------------------

# Encrypt minio secret to pass as a secret env variable.
secret = 'PASSWORD'
minio_secret_encrypted = j.sals.zos.get().container.encrypt_secret(minio_node_id, secret)
shards_encrypted = j.sals.zos.get().container.encrypt_secret(minio_node_id, ",".join(namespace_config))
secret_env = {"SHARDS": shards_encrypted, "SECRET_KEY": minio_secret_encrypted}

# Make sure to adjust the node_id and network name to the appropriate in copy / paste mode :-)
minio_container=zos.container.create(
 node_id=minio_node_id,
 network_name=demo_network_name,
 ip_address=minio_node_ip,
 flist='https://hub.grid.tf/tf-official-apps/minio:latest.Flist',
 capacity_pool_id=minio_pool_id,
 interactive=False,
 entrypoint='',
 cpu=2,
 memory=2048,
 env={
  "DATA":"4",
  "PARITY":"2",
  "ACCESS_KEY":"minio",
  "SSH_KEY": USER_ACCESS_KEY, # (your id_rsa.pub key) OPTIONAL to provide ssh access to the deployed container.
  "MINIO_PROMETHEUS_AUTH_TYPE": "public"
  },
 secret_env=secret_env,
 )

# ----------------------------------------------------------------------------------
# Attach persistent storage to container - for storing metadata
# ----------------------------------------------------------------------------------
zos.volume.attach_existing(
 container=minio_container,
 volume_id=volume,
 mount_point='/data')

# Deploy the minio container
zos.workloads.deploy(minio_container)
```
