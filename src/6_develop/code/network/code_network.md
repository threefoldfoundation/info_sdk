## Create a private overlay network

In this example we will create an overlay network over a number of nodes in the TF Grid.  The nodes and locations can be researched on this explorer site:  http://explorer.grid.tf



#### 1. Load required libraries and create empty reservation structure

To be able to made a reservation we need to local the System Abstraction Layer (SAL) and create an empty reservation structure


```bash
# Load the zero-os sal and create empty reservation method
zos = j.sals.zos
r = zos.reservation_create()
```

#### 2. Select overlay network addressing scheme and select nodes

In this example we added all the nodes from Salzburg, Vienna, Lochristi and Munich are into one list.  You can shorten that list by selecting smaller sections of that list. For people that do not have IPv6 at home we need have at least one node on the network that has IPv4 access for the wireguard tunnel to terminate.  


```bash
demo_ip_range="172.20.0.0/16"
demo_port=8030
demo_network_name="demo_network_name_01"
```

Now you need to look and select which nodes you want in your network.  You can browse all available nodes on the [explorer.grid.tf](https://explorer.grid.tf/)

The following code assumes that you know the farmer ID's of the farmers listed on the explorer.  Here is how you can find the farmer ID:

```bash
# create overlay network definition in datastructure called "network"
network = zos.network.create(r, ip_range=demo_ip_range, network_name=demo_network_name)

nodes_salzburg = zos.nodes_finder.nodes_search(farm_id=12775) # (IPv6 nodes)
nodes_vienna_1 = zos.nodes_finder.nodes_search(farm_id=82872) # (IPv6 nodes)
nodes_belgium = zos.nodes_finder.nodes_search(farm_id=1) # (IPv4 nodes, to be used as ingress/egress point.  These are not webgatewaysm, just nodes connected to the internet with IPv4 addresses)

# nodes_all = nodes_salzburg + nodes_vienna_1 + nodes_belgium + nodes_munich
nodes_all = nodes_salzburg[5:8] + nodes_vienna_1[5:8] + nodes_belgium[:2]

# make sure to set a new port
for i, node in enumerate(nodes_all):
    if zos.nodes_finder.filter_is_up(node):
        iprange = f"172.20.{i+10}.0/24"
        zos.network.add_node(network, node.node_id , iprange)
        print("Node number: ", i, node.node_id, ":", iprange)
    else:
        print("Node", node.node_id,"is not up")
```

Please store the list of nodes somewhere for you reference to deploy containers and architectures, or you can write code to store this to a file.  All nodes are connected with IPv6 to the internet.  If you have IPv6 at home you can create a wireguard configuration to any of the nodes as they all speak IPv6 and any node can act as you private gateway into your overlay network.  If you fo not have IPv6 at home you need to identify a nodes that has IPv4 capabilities.  In this example the nodes in Belgium have a dual-stack and can therefore be used to provide an IPv4 gateway into your overlay network.

#### 3.  Setup wireguard configuration

An important step is to create a wireguard configuration (file) providing you with secure access to you private peer2peer overlay network.  Please copy / paste the  configuration into a file and import to you local wireguard setup.  At time of writing IPv4 was the only available stack and therefore this example has an IPv4 Wireguard configuration, based on one of the nodes in Belgium.  With IPv6 available you can select any of the nodes in your network and build a secure tunnel to those. 


```bash
# Enter here the node_id for the node that is the IPv4 bridge to create the wireguard config.
wg_config = zos.network.add_access(network, 'CBDY1Fu4CuxGpdU3zLL9QT5DGaRkxjpuJmzV6V5CBWg4', '172.20.100.0/24', ipv4=True)

print("------------------------")
print(wg_config)
print("------------------------")
```

Copy the wireguard configuration to your local host on which the TFGrid SDK is running and bring the wireguard interface up.  Instructions to do this are [here](https://www.wireguard.com/quickstart/)

#### 4. Register reservation to the grid

Now that we have built a network reservation structure which includes on the nodes we want to use, here how to send this reservation to the grid.

```bash
# Set the duration for the reservation
# Reservation period set in seconds. Please adjust, this only allys for the network to exists for 60 minutes.
reservation_period=(60*60)

expiration = j.data.time.utcnow().timestamp + reservation_period

# Register the reservation.  All required data has been loaded in the reservation structrure: r
rid = zos.reservation_register(r, expiration)
```

The returned number of the reservation number of the network reservation.  To retrieve the actual content of the reservation you can use the following command after waiting


```bash
# inspect the result of the reservation provisioning
result = zos.reservation_result(rid)

print("provisioning result")
print(result)
```

This will provide you with an overlay network.  It is wise to do this once for the nodes that you want in your network and then do a reservation for a long period.  This will allow you to continue to work, deploy, optimize and configure all necessary components for the work on the grid.  Obviously
