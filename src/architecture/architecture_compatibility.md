# A new architecture, compatible with existing IT standards 

Threefold has built this revolutionary review of the internet infrastructure to become fully peer2peer and used by everyone. It's done however in full compatibility with the standards of the IT industry, in many dimensions.

## Hardware compatibility

The Zero-OS operating system can be installed on any server hardware with secure boot capabilities. 
This implies that a simple installation of the Zero-OS image converts the hardware into a 3Node. 

## Compatibility with S3 standards for storage

You can read in the [Peer2Peer Storage](./architecture_storage.md) section about how we organise and disperse storage. It can be set up based on the [min.io](https://min.io) S3 API interface. 

## Compatibility with container standards 

[Zero-OS hub](https://hub.grid.tf) is the repository of publicly available flists, the Virtual File System for Containers and Virtual Machines. 

The flist contains some major improvements compared to the container formats in the market, but we made it in a way that it is fully compatible with Docker, the best known container format available.
Even more, it is really simple to convert your existing Docker file into a flist. The docker Hub Converter converts any existing Docker image into a flists, publishes it on the hub. Once converted the container is usable on the Threefold Grid, out of the box !

Next to this, also Kubernetes, best known container orchestrator, runs on the Threefold grid and can be used to orchestrate Docker containers. 

Containers can hold any object. As they are supported on the TF Grid, the complexity of installing any IT workload is reduced to simple container management. 

## Compatibility with network standards

The network standard for interconnecting 3Nodes on the TFGrid is the IPv6 protocol. 
This choice is inspired by the conviction that IPv6 will be the standard network protocol at some point in time, so it needs to be supported even if the hosting network doesn't provide it yet. 
Choosing for IPv6 is future-proof and solves 2 problems : 
   - the number of public IPv4 addresses is limited and gets exhausted
   - it allows complex IP management between nodes in one and the same farm
   
Each node in the grid must be able to connect to any other node, so having public IPv6 address everywhere made it very easy, solving all these pesky NAT and unreachable node problems.
We realise however that IPv4 is still widespread. To make IPv4-only nodes reachable, ZOS has integrated Yggdrasil. 
Yggdrasil is an implementation of a fully end-to-end encrypted IPv6 network where nodes are part of a globally-agreed spanning tree.
It allows traffic to be forwarded between all nodes of the network.

