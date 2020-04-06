## Deploy a a kubernetes cluster

#### Requirements

In order to be able to deploy this example deployment you will have to have the following components activated
- the Jumpscale SDK, in the form of a local container with the SDK, or a grid based SDK container.  Getting started instuctions are [here](/grid/peer2peer_storage_compute/general/jumpscale_SDK) 
- if you use a locally installed container with the 3bot SDK you need to have the wireguard software installed.  Instructions to how to get his installed on your platform can be found [here](https://www.wireguard.com/install/)

After following these install instructions you should end up having a local, working jumpscale SDK installed.  You can work / connect to the installed SDK as described [here](/grid/peer2peer_storage_compute/general/jumpscale_SDK/SDK_getting_started.md)

### Overview
The design a simple kubernetes cluster we need to follow a few steps:
- create (or identify and use) an overlay network that spans all of the nodes needed in the solution
- identify which nodes are involved in the kubernetes cluster, master and worker nodes
- create reservations for the kubernetes virtual machines.
- deploy the kubernetes cluster.

#### Create overlay network of identity an previously deployed overlay network

Each overlay network is private and contains private IP addresses.  Each overlay network is deployed in such a way that is has no connection to the public (IPv4 or IPv6) network directly.  In order to work with such a network a tunnel needs to be created between the overlay network on the grid and your local network.  You can find instructions how to do that [here](/grid/peer2peer_storage_compute/use_cases/examples/jupyter/network/overlay_network.md)


#### Set up the capacity environment to find, reserve and configure

Make sure that your SDK points to the mainnet explorer for deploying this capacity example.  Also make sure you have an identity loaded.  The example code uses the default identity.  Multiple identities can be stored in the jumpscale SDK.  To check your available identities you can request the number of identities available for you by typing `j.tools.threebot.me` in the kosmos shell.



```python
from Jumpscale import j
import time

# Which identities are available in you SDK
j.tools.threebot.me

# Make sure I have an identity (set default one for mainnet of testnet)
me = j.tools.threebot.me.default
j.clients.threebot.explorer_addr_set('explorer.grid.tf')

# Load the zero-os sal and reate empty reservation method
zos = j.sal.zosv2
r = zos.reservation_create()
```

#### Setup your overlay network (skip this step if you have a network setup and available)

An overlay network creates a private peer2peer network over selected nodes.  In this notebook it is assumend you have created one by following this [notebook](/grid/peer2peer_storage_compute/use_cases/examples/jupyter/kubernetes_cluster/kubernetes_cluster.ipynb)

#### Design the Kubernetes cluster

You have created a network in the network creation [notebook](/grid/peer2peer_storage_compute/use_cases/examples/jupyter/kubernetes_cluster/kubernetes_cluster.ipynb) with the following details:
```
demo_ip_range="72.20.0.0/16"
demo_port=8030
demo_network_name="demo_network_name_01"
```
When you executed the reservation it also provided you with data on order number, node ID and private network range on the node.  All the nodes in the network are connected peer2peer with a wireguard tunnel.  On these nodes we can now create the kubernetes solution.  For this soultion we will be using some of these nodes as master nodes and others as worker nodes.  Using the ouput of the network reservation notebook to describe the high level design of the kubernetes cluster:

| Nr.  |  Location | Node ID.   |  IPV4 network    | Function.  |
|--------|---|---|---|---|
|    1    | Salzburg  | 9kcLeTuseybGHGWw2YXvdu4kk2jZzyZCaCHV9t6Axqqx  | 172.20.15.0/24  | Master node  |
|    2    | Salzburg  | 3h4TKp11bNWjb2UemgrVwayuPnYcs2M1bccXvi3jPR2Y  | 172.20.16.0/24  |  Worker node |
|    3    | Salzburg  |  FUq4Sz7CdafZYV2qJmTe3Rs4U4fxtJFcnV6mPNgGbmRg | 172.20.17.0/24  |  Worker node |
|    4    | Vienna  |  9LmpYPBhnrL9VrboNmycJoGfGDjuaMNGsGQKeqrUMSii | 172.20.28.0/24  |  Worker node |
|    5    | Vienna  |  3FPB4fPoxw8WMHsqdLHamfXAdUrcRwdZY7hxsFQt3odL | 172.20.29.0/24  |  Worker node |
|    6    | Vienna  |  CrgLXq3w2Pavr7XrVA7HweH6LJvLWnKPwUbttcNNgJX7 | 172.20.30.0/24  |  Worker node |


#### Reserve and deploy the master and worker nodes

A Kubernetes cluster is built from master and worker nodes.  Based on the network that we have build we can build and deploy nodes in Vienna and Salzbug,


```python
# load the zero-os sal
zos = j.sal.zosv2

day=24*60*60
hour=60*60

cluster_secret = 'supersecret'

# At this point in time we have two sizes of virtual machines for Kubernetes clusters.
# size 1 = 1 logical core and 2GB of memory
# size 2 = 2 logical cores and 4GB of memory
size = 1

# set in the example network deployment - please replace with your personal network name.
network_name = 'demo_network_name_01'

# exmaple public ssh key.  This is used to log in two the cluster nodes - please replace with you own ssh-key.
sshkeys = ['ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMtml/KgilrDqSeFDBRLImhoAfIqikR2N9XH3pVbb7ex zaibon@tesla']
```

Create the master node reservations.  The function add the nodes to the reservation structure `r`.


```python
# Create reservation for master
master = zos.kubernetes.add_master(
    reservation=r,
    node_id='9kcLeTuseybGHGWw2YXvdu4kk2jZzyZCaCHV9t6Axqqx',
    network_name=network_name,
    cluster_secret=cluster_secret,
    ip_address='172.20.15.20',
    size=size,
    ssh_keys=sshkeys)
```

Now that we have defined the master node, let us deploy worker nodes.  Worker nodes can exists anywhere in the deployed network so here we create 2 in Salzburgh and 2 in Vienna


```python
# Repeat for worker nodes, or create a looped assignment

worker_1 = zos.kubernetes.add_worker(
    reservation=r,
    node_id='3h4TKp11bNWjb2UemgrVwayuPnYcs2M1bccXvi3jPR2Y',
    network_name=network_name,
    cluster_secret=cluster_secret,
    ip_address='172.24.16.20',
    size=size,
    master_ip=master.ipaddress,
    ssh_keys=sshkeys)

worker_2 = zos.kubernetes.add_worker(
    reservation=r,
    node_id='FUq4Sz7CdafZYV2qJmTe3Rs4U4fxtJFcnV6mPNgGbmRg',
    network_name=network_name,
    cluster_secret=cluster_secret,
    ip_address='172.24.17.20',
    size=size,
    master_ip=master.ipaddress,
    ssh_keys=sshkeys)

worker_3 = zos.kubernetes.add_worker(
    reservation=r,
    node_id='9LmpYPBhnrL9VrboNmycJoGfGDjuaMNGsGQKeqrUMSii',
    network_name=network_name,
    cluster_secret=cluster_secret,
    ip_address='172.24.28.20',
    size=size,
    master_ip=master.ipaddress,
    ssh_keys=sshkeys)


```


```python
With the reservation structure done we can now reserve the cluster.
```


```python
expiration = j.data.time.epoch + (24*hour)

# register the reservation
rid = zos.reservation_register(r, expiration)
time.sleep(120)
# inspect the result of the reservation provisioning
result = zos.reservation_result(rid)

print("provisioning result")
print(result)
# ----------------------------------------------------------------------------------
# Select and create a reservation for nodes to deploy a ZDB
# first find the node where to reserve 0-db namespaces.  Select all the salzburg nodes
# ----------------------------------------------------------------------------------
```

With the low level reservations done and stored the `result`.  You are now able to access you kubernetes cluster on the assigned IP addresses



```python

```
