## Deploy a Kubernetes cluster

#### Requirements

Please check the [general requirements](code.md)

### Overview
The aim is to create a simple Kubernetes cluster where we need to follow a few steps:
- Create (or identify and use) an overlay network that spans all of the nodes needed in the solution.
- Identify which nodes are involved in the Kubernetes cluster, master and worker nodes.
- Deploy Kubernetes virtual machines.
- Deploy the Kubernetes cluster.

#### Create an overlay network of identity a previously deployed overlay network

Each overlay network is private and contains private IP addresses. Each overlay network is deployed in such a way that it has no connection to the public (IPv4 or IPv6) network directly. In order to work with such a network a tunnel needs to be created between the overlay network on the grid and your local network. You can find instructions how to create a network [here](code_network.md).



#### Design the Kubernetes cluster

You have created a network in the network creation [tutorial](code_network.md) with the following details:

```python
demo_ip_range="172.20.0.0/16"
demo_port=8030
demo_network_name="demo_network_name_01"
```

When you executed the reservation it also provided you with data on the order number, node ID and private network range on the node. All the nodes in the network are connected peer-to-peer with a wireguard tunnel. On these nodes we could now create the Kubernetes solution. For this solution we will be using some of these nodes as master nodes and others as worker nodes. Using the output of the network reservation notebook to describe the high-level design of the Kubernetes cluster:

| Nr. | Location | Node ID. | IPV4 network | Function. |
|--------|---|---|---|---|
| 1 | Salzburg | 9kcLeTuseybGHGWw2YXvdu4kk2jZzyZCaCHV9t6Axqqx | 172.20.15.0/24 | Master node |
| 2 | Salzburg | 3h4TKp11bNWjb2UemgrVwayuPnYcs2M1bccXvi3jPR2Y | 172.20.16.0/24 | Worker node |
| 3 | Salzburg | FUq4Sz7CdafZYV2qJmTe3Rs4U4fxtJFcnV6mPNgGbmRg | 172.20.17.0/24 | Worker node |
| 4 | Vienna | 9LmpYPBhnrL9VrboNmycJoGfGDjuaMNGsGQKeqrUMSii | 172.20.28.0/24 | Worker node |
| 5 | Vienna | 3FPB4fPoxw8WMHsqdLHamfXAdUrcRwdZY7hxsFQt3odL | 172.20.29.0/24 | Worker node |
| 6 | Vienna | CrgLXq3w2Pavr7XrVA7HweH6LJvLWnKPwUbttcNNgJX7 | 172.20.30.0/24 | Worker node |


#### Reserve and deploy the master and worker nodes

A Kubernetes cluster is built from master and worker nodes. Based on the network that we have build we could build and deploy nodes in Vienna and Salzburg.


```python
# Load the zero-os sal and create an empty reservation instance.
zos = j.sals.zos

cluster_secret = 'supersecret'

# At this point in time we have two sizes of virtual machines for Kubernetes clusters.
# Size 1 = 1 logical core and 2GB of memory.
# Size 2 = 2 logical cores and 4GB of memory.
size = 1

# Set in the example network deployment - please replace with your personal network name.
network_name = 'demo_network_name_01'

# Example public ssh key. This is used to log in two the cluster nodes - please replace with you own ssh-key.
sshkeys = ['ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMtml/KgilrDqSeFDBRLImhoAfIqikR2N9XH3pVbb7ex zaibon@tesla']
```

Create master node reservations. The function add the nodes to the reservation structure `r`.

```python
cluster = []

master = zos.kubernetes.add_master(
 node_id={string},   # Node_id to make the capacity reservation on and deploy the Flist.
 network_name={string},  # Network_name deployed on the node (node could have multiple private networks).
 cluster_secret={string}, # Cluster pasword.
 ip_address={string},  # IP address the network range defined by network_name on the node.
 size={integer},   # 1 (1 logical core, 2GB of memory) or 2 (2 logical cores and 4GB of memory).
 ssh_keys={string},   # Ssh public key providing ssh access to master of worker vm's.
 pool_id={integer})
cluster.append(master)
```

Now that we have defined the master node, let us deploy worker nodes.

```python
# Repeat for worker nodes, or create a looped assignment.

worker1 = zos.kubernetes.add_worker(
 node_id='3h4TKp11bNWjb2UemgrVwayuPnYcs2M1bccXvi3jPR2Y',
 network_name=network_name,
 cluster_secret=cluster_secret,
 ip_address='172.24.16.20',
 size=size,
 master_ip=master.ipaddress,
 ssh_keys=sshkeys,
 pool_id=62)

cluster.append(worker1)

worker2 = zos.kubernetes.add_worker(
 node_id='FUq4Sz7CdafZYV2qJmTe3Rs4U4fxtJFcnV6mPNgGbmRg',
 network_name=network_name,
 cluster_secret=cluster_secret,
 ip_address='172.24.17.20',
 size=size,
 master_ip=master.ipaddress,
 ssh_keys=sshkeys,
 pool_id=62)
cluster.append(worker2)

worker3 = zos.kubernetes.add_worker(
 node_id='9LmpYPBhnrL9VrboNmycJoGfGDjuaMNGsGQKeqrUMSii',
 network_name=network_name,
 cluster_secret=cluster_secret,
 ip_address='172.24.28.20',
 size=size,
 master_ip=master.ipaddress,
 ssh_keys=sshkeys,
 pool_id=62)
cluster.append(worker3)
```

And finally deploy each of the K8S VMs (master and workers).

```bash
for w in cluster:
 zos.workloads.deploy(w)
```

You are now able to access your Kubernetes cluster on the assigned IP addresses.
