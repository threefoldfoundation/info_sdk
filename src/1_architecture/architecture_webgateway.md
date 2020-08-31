
## Web Gateway Architecture

### Introduction
__The Web Gateway__ is an important component that exposes anything deployed on the TF Grid to the open internet. TF Grid works natively with IPv6 (and IPv4 in locations where IPv6 is not available), and is by default not exposing any of the reservered overlay networks to the open internet and the private overlay network (please find more information on the [network](architecture_network.md). 

### Capacity farming and network farming
TG Grid is built by farmers that invest and deploy the hardware on which Zero-OS runs; creating a peer2peer IT capacity on top of the TF Grid. Each node is as important as any other node, and all together, they form this universal substrate for IT workloads. Although all nodes are equal in this grid, they do not all come equal in the sense of network connectivity. Besides the obvious differences of having redundant network upstream connections (most data center set-ups), or having small, medium, and large upstream bandwidth available (home setups versus office and data center set-ups).

Beyond these differences there will be another one: the number of usable IP addresses on a site. Some sites will not be able to have more than one IP address available (IPv6 or IPv4), and therefore are not suited to serve online services for anyone. The 3Nodes that are connected to the internet with only one IP address available are called the "hidden" 3Nodes. More details could be found [here](https://github.com/Threefoldtech/zos/blob/master/docs/network/setup_farm_network.md). To be able to allow anyone to participate and create a capacity to this universal substrate (capacity farming), we require the network farm to connect hidden nodes to the internet to expose digital services.

Network farmers are farmers that have access to a location where there is good network connectivity and a large(r) amount of IP addresses. This large(r) amount of IP addresses and good upstream connectivity make these sites ideal to create Ingress/Egress points for private overlay networks.

This architecture allows total freedom to choose where to process and store data to happen. When the data or content is ready to be exposed to the rest of the world, the Web Gateway provides the total freedom to select the best possible location for that to happen. True peer2peer in every aspect.

### Scale-out Architecture

The independence of network and location created by the Web Gateway allows this architecture to scale endlessly. There is no limit to the amount of 3Nodes that could be added to the TF Grid to create more universal substrates, and the number of Ingress and Egress points scale independently from that. This results in a true Peer2Peer and scale-out architecture.

