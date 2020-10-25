## Create a private overlay network

In this example, we will create an overlay network over a number of nodes in the TF Grid. The nodes and locations could be researched on the explorer:

- Mainnet: https://explorer.grid.tf
- Testnet: https://explorer.testnet.grid.tf

#### Requirements

Please check the [general requirements](code.md).

#### 1. Load required libraries and create empty reservation structure.

To be able to make a reservation, we need to create a [capacity pool](code_pool.md).

#### 2. Select overlay network addressing scheme and select nodes.

In this example, we added all nodes from the farm called `lochristi_dev_lab` into our network.

```python
demo_ip_range="172.20.0.0/16"
demo_port=8030
demo_network_name="demo_network_name_01"
```

The following code creates the network:

```python
# Create overlay network definition in a data structure called "network".
network = zos.network.create(ip_range=demo_ip_range, network_name=demo_network_name)

# Nodes that you allocated in a pool are eligible for creating your network.
# Beware you have to indicate which pool you use for the resource you add to the network.
# in our example the pool has ID 12
pool_id = 12

# Make sure to set a new port.
nodes = zos.nodes_finder.nodes_search(farm_name='lochristi_dev_lab')
for i, node in enumerate(nodes):
  if zos.nodes_finder.filter_is_up(node):
    iprange = f"172.20.{i+10}.0/24"
    zos.network.add_node(network, node.node_id , iprange, pool_id)
    print("Node number: ", i, node.node_id, ":", iprange)
  else:
    print("Node", node.node_id,"is not up")
```

All nodes are connected with IPv6 to the internet. If you have IPv6 at home you can create a wireguard configuration to any of the nodes as they all speak IPv6 and any node can act as you private gateway into your overlay network. If you do not have IPv6 at home you need to identify a nodes that has IPv4 capabilities. In this example the nodes in Belgium have a dual-stack and can therefore be used to provide an IPv4 gateway into your overlay network.

#### 3. Setup wireguard configuration

An important step is to create a wireguard configuration (file) providing you with secure access to your private peer-to-peer overlay network. Please copy / paste the configuration into a file and import to you local wireguard setup. At time of writing IPv4 was the only available stack and therefore this example has an IPv4 Wireguard configuration, based on one of the nodes in Belgium. With IPv6 available you could select any of the nodes in your network and build a secure tunnel to those.


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

##### 4. New API, deploy as a workload

```python
# Deploy the network
zos.workloads.deploy(network)
```
