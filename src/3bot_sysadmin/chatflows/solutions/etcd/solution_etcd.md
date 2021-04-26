# ETCD
A distributed, reliable key-value store for the most critical data of a distributed system

## Steps to Deploy ETCD

### Add the solution name
![](./img/Single_ETCD/01.png)

### Choose Number of ETCD Nodes
- Single Node 
![](./img/Single_ETCD/02.png)

- Cluster Nodes: Here we choose cluster of 3 nodes (Odd number preferable)
![](./img/Cluster_ETCD/02.png)

### Choose Container Resources
Here we specify the CPU and Memory resources allocated for the container
![](./img/Single_ETCD/03.png)

### Select a Pool
![](./img/Single_ETCD/04.png)

### Choose a Network
![](./img/Single_ETCD/05.png)

### Choose Global IPv6 Address Configuration
![](./img/Single_ETCD/06.png)

### Ask for Automatically Select Node
Here we could provide a node id corresponding to a current node on the grid to deploy the container on. If there is no specific node to be used then it is choose `Yes`.
![](./img/Single_ETCD/07.png)

### Choosing Private IP

It will appear according to the number of ETCD nodes

- Single Node
![](./img/Single_ETCD/08.png)

- Cluster Nodes:
1. Node 1
![](./img/Cluster_ETCD/08_1.png)
2. Node 2
![](./img/Cluster_ETCD/08_2.png)
3. Node 3
![](./img/Cluster_ETCD/08_3.png)

### Deploying Your Solution
![](./img/Single_ETCD/09.png)

### Success Message

- Single Node
![](./img/Single_ETCD/10.png)

- Cluster Nodes
![](./img/Cluster_ETCD/10.png)

## Try ETCD From Your Terminal

> By using the command(s) from success message

- Single node
![](./img/Single_ETCD/11.png)

- Cluster nodes
![](./img/Cluster_ETCD/11.png)

## ETCD Info

You can access info of your solution from dashboard and will appear like the following:

### Single Node Info
![](./img/Single_ETCD/12.png)

### Cluster Nodes Info
![](./img/Cluster_ETCD/12.png)