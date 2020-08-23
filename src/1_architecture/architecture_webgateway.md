
## Webgateway architecture

![](./img/gateway.png)

### Introduction
The webgateway is an important component of exposing anything deployed on the TF Grid to the open Internet. TF Grid works natively with IPv6 (and IPv4 in locations where IPv6 is not available) and is by default not exposing any of the reservered overlay networks to the open Internet (please find more information on the [network](architecture_network.md) the open Internet and the private overlay network. 

### Capacity farming and network farming
TG Grid is built by farmers that invest and deploy hardware on which Zero-OS runs creating a peer2peer grid capacity generating grid. Each node is as important as any other node and all together they form this universal substrate for IT workloads. Although all nodes are equal in this grid they do not all come equal in the sense of network connectivity. Besides the obvious differences of having redundant network upstream connections (most datacenter setups) or having small, medium and large upstream bandwidth available (home setups versus office and datacenter setups).

Beyond these differences there will be another one: The number of usable IP addresses on a site. Some sites will not be able to have more than one IP address available (IPv6 or IPv4) and therefore are not suited to serve online services for anyone. The 3Nodes that are connected to the internet with only one IP address available are called "hidden" 3Nodes. More details could be found [here](https://github.com/Threefoldtech/zos/blob/master/docs/network/setup_farm_network.md). To be able to allow anyone to participate and create capacity to this universal substrate (capacity farming) we require network farming to connect hidden nodes to the internet to expose digital services.

Network farmers are farmers that have access to a location where there is good network connectivity and a large(r) amount of IP addresses. This large(r) amount of IP addresses and good upstream connectivity makes these sites ideal to create Ingress/Egress points for private overlay networks.
![](./img/webgateway_topo.png)
This architecture allows for total freedom to choose where to process and store data. When the data / content is ready to be exposed to the rest of the world the webgateway provides total freedom to select the best possible location for that to happen. True peer2peer in every aspect.

<!--
Source code could be found here: https://github.com/Threefoldtech/tcprouter
-->

### Scaleout architecture
![](./img/webgateway_scale.png)

The independence of network and location created by the webgateway allows this architecture to scale endlessly. There is no limit to the amount of 3Nodes that could be added to the TF Grid to create more universal substrates and the number of Ingress and Egress points scale independently from that. This results in a true Peer2Peer and scaleout architecture.

