## Create a private overlay network

In this example we will create an overlay network over a number of nodes in the TF Grid. The nodes and locations could be researched on this explorer site: http://explorer.grid.tf


#### Requirements

Please check the [general requirements](code.md)

#### 1. Load required libraries and create empty reservation structure

To be able to made a reservation we need to local the System Abstraction Layer (SAL) and create a [capacity pool](code_pool.md)

#### 2. Select overlay network addressing scheme and select nodes

In this example we added all the nodes from Salzburg, Vienna, Lochristi and Munich are into one list. You could shorten that list by selecting smaller sections of that list. For people that do not have IPv6 at home we need have at least one node on the network that has IPv4 access for the wireguard tunnel to terminate. 


```bash
demo_ip_range="172.20.0.0/16"
demo_port=8030
demo_network_name="demo_network_name_01"
```

Now you need to look and select which nodes you want in your network. You could browse all available nodes on the [explorer.grid.tf](https://explorer.grid.tf/)

The following code assumes that you know the farmer ID's of the farmers listed on the explorer. Here is how you could find the farmer ID:

```bash
# create overlay network definition in datastructure called "network"
network = zos.network.create(ip_range=demo_ip_range, network_name=demo_network_name)

# use the pool

pool = zos.pools.get(payment_detail.reservation_id)

# Nodes that you allocated in a pool are eligible for creating your network
# Beware you have to indicate which pool you use for the resource you add to the network

# make sure to set a new port
for i, node in enumerate(pool.node_ids):
 if zos.nodes_finder.filter_is_up(node):
  iprange = f"172.20.{i+10}.0/24"
  pool_id = 1
  zos.network.add_node(network, node.node_id , iprange, pool_id)
  print("Node number: ", i, node.node_id, ":", iprange)
 else:
  print("Node", node.node_id,"is not up")
```

Please store the list of nodes somewhere for you reference to deploy containers and architectures, or you could write code to store this to a file. All nodes are connected with IPv6 to the internet. If you have IPv6 at home you could create a wireguard configuration to any of the nodes as they all speak IPv6 and any node could act as you private gateway into your overlay network. If you fo not have IPv6 at home you need to identify a nodes that has IPv4 capabilities. In this example the nodes in Belgium have a dual-stack and could therefore be used to provide an IPv4 gateway into your overlay network.

#### 3. Setup wireguard configuration

An important step is to create a wireguard configuration (file) providing you with secure access to you private peer2peer overlay network. Please copy / paste the configuration into a file and import to you local wireguard setup. At time of writing IPv4 was the only available stack and therefore this example has an IPv4 Wireguard configuration, based on one of the nodes in Belgium. With IPv6 available you could select any of the nodes in your network and build a secure tunnel to those. 


```bash
# Enter here the node_id for the node that is the IPv4 bridge to create the wireguard config.
wg_config = zos.network.add_access(network, 'CBDY1Fu4CuxGpdU3zLL9QT5DGaRkxjpuJmzV6V5CBWg4', '172.20.100.0/24', ipv4=True)

print("------------------------")
print(wg_config)
print("------------------------")
```

Copy the wireguard configuration to your local host on which the TF Grid SDK is running and bring the wireguard interface up. Instructions to do this are [here](https://www.wireguard.com/quickstart/)

The network is now a workload that needs to be deployed. 

#### 4. Deploy the network to the grid

Now that we have built a network workload structure which includes the nodes we want to use, here is how to deploy this network as a workload to the grid.

##### 4a. New API, deploy as a workload

```bash
# Deploy the network
zos.workloads.deploy(network)
```

If the network is composed of different pools / different farmers, you simply loop over the different workloads :

```bash
# Deploy the network 
r = zos.reservation_create()
r.workloads.append(network)
for nr in network.network_resources:
 zos.workloads.deploy(nr)
```

##### 4b. The old way of reserving network resources (without expiration date) is still supported but not recommended :

```bash
r = zos.reservation_create()
rid = zos.reservation_register(r)
```

The returned number of the reservation number of the network reservation. To retrieve the actual content of the reservation you could use the following command after waiting


```bash
# inspect the result of the reservation provisioning
result = zos.reservation_result(rid)

print("provisioning result")
print(result)
```

This will provide you with an overlay network. 

