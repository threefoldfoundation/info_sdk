### Deploy a generic container using an Flist

#### Requirements

Please check the [general requirements](code)

### Overview
The aim is to deploy a simple container using an Flist which is further describer below.



#### Create an overlay network or identity a previously deployed overlay network

Each overlay network is private and contains private IP addresses. Each overlay network is deployed in such a way that they have no connection to the public (IPv4 or IPv6) network directly. To work with such a network a tunnel needs to be created between the overlay network, on the grid and your local network. You could find instructions on how to create a network [here](code_network)


#### What is a Flist?

An Flist is a very special container image. One of the challenges with industry-leading technologies like Docker and Kubernetes is that every node involved in an IT architecture has to have local copies of all of the images it needs to run as containers. These could either be base images on which specific modifications need to be made or specific images downloaded from the docker hub or a private image repository (enterprise use cases). Having these images exists on many different nodes requires these to be downloaded and maintained for version control and bug fixes. This is wasteful (many times the same image required storage space) and time-consuming.

The Flist solves that issue by facilitating container images to be made available on fly to nodes that need the content of a container image over the network from a so-called hub. There is a public hub that serves images, but the hub facility is open source. It could be replicated for private or corporate usage. The hub could be found here: `http://hub.grid.tf`.

The Flist represents a very efficient way to distribute a de-duped container image with a bandwidth optimized transfer process and increased security by signed files. For (a lot) more details, please go here:

 * generic description [here](https://github.com/Threefoldtech/0-Flist/blob/development/doc/flist.md)
 * GitHub repository [here](https://github.com/Threefoldtech/0-Flist)
 * FreeFlow pages [article](http://freeflowpages.com/content/perma?id=9396)

On the public hub there is import functionality to import Docker images and create Flists out of them. Another way to create your own tar archives and upload these to transform into Flists. More information with regards to creating, managing and using Flists could be found [here](https://hub.grid.tf/)

You could find more information about Flist and hub usage [here](flist)

#### Select which Flist to deploy?

For this example, we selected the code-server Flist in a public hub. The code-server Flist is based on an open opensource software managed here: https://github.com/Microsoft/vscode. Its visual studio code provides a very feature-rich coding and code management environment. The Flist could be found [here](https://hub.grid.tf/weynandkuijpers.3bot/codercom-code-server-latest.Flist).

#### Node selection and parameters.
You have created a network in the network creation [tutorial](code_network) with the following details:

```python
demo_ip_range="172.20.0.0/16"
demo_port=8030
demo_network_name="demo_network_name_01"
```
When you executed the network workload, it also provided you with data on the order number, node ID and private network range on the node. All the nodes in the network are connected peer-to-peer with a wireguard tunnel. On these nodes, we could now launch the Flist. For this solution, we will be using some of these nodes as master nodes and others as worker nodes. Using the output of the network reservation notebook to describe the high-level design of the Kubernetes cluster:

| Nr. | Location | Node ID. | IPV4 network | Function. |
|--------|---|---|---|---|
| 1 | Salzburg | 9kcLeTuseybGHGWw2YXvdu4kk2jZzyZCaCHV9t6Axqqx | 172.20.15.0/24 | Available |
| 2 | Salzburg | 3h4TKp11bNWjb2UemgrVwayuPnYcs2M1bccXvi3jPR2Y | 172.20.16.0/24 | Available |
| 3 | Salzburg | FUq4Sz7CdafZYV2qJmTe3Rs4U4fxtJFcnV6mPNgGbmRg | 172.20.17.0/24 | Available|
| 4 | Vienna | 9LmpYPBhnrL9VrboNmycJoGfGDjuaMNGsGQKeqrUMSii | 172.20.28.0/24 | Available |
| 5 | Vienna | 3FPB4fPoxw8WMHsqdLHamfXAdUrcRwdZY7hxsFQt3odL | 172.20.29.0/24 | Available |
| 6 | Vienna | CrgLXq3w2Pavr7XrVA7HweH6LJvLWnKPwUbttcNNgJX7 | 172.20.30.0/24 | Available |


The reservation for a general-purpose Flist has the following structure
```python
zos.container.create(node_id={string},    # node_id to deploy the Flist
     network_name={string},  # network_name deployed on the node (node could have multiple private networks)
     ip_address={string},   # one IP address in the range of the chosen network_name on the node
     flist={string},    # Flist of the container you want to install, htttp hub location.
     capacity_pool_id={integer}, # pool_id of where the capacity for container deployment is to be used from
     interactive={Bolean},   # True of False. When True the entrypoint start commend is ignored and a web interface to the coreX process will de started instead
     cpu={integer},    # number of logical cores
     memory={integer,   # number of mBs of memory
     # env={},      # field for parameters like needed in the container environment
     entrypoint={string})   # start command to get the software running in the container
```

For more details and options, please see [here](https://github.com/Threefoldtech/js-sdk/blob/development/jumpscale/sals/zos/container.py)

Providing the correct details allows us to deploy the code-server container.


```python
zos = j.sals.zos.get()

# use the pool
pool = zos.pools.get(payment_detail.reservation_id)

# Add data to method to what to deploy. Example is code server
container = zos.container.create(node_id='CrgLXq3w2Pavr7XrVA7HweH6LJvLWnKPwUbttcNNgJX7', # one of the node_id that is part of the network
     network_name=u_networkname, # this assume this network is already provisioned on the node
     ip_address='172.20.30.11', # part of ip_range you reserved for your network xxx.xxx.1.10
     flist='https://hub.grid.tf/weynandkuijpers.3Bot/codercom-code-server-latest.Flist', # Flist of the container you want to install
     capacity_pool_id=pool.pool_id, # ID of the capacity pool you have created and that you want to deploy the container on
     interactive=True,   # True only if corex_connect required, default false
     cpu=4, # request 4 virtual CPU
     memory=4196, # request 4 GiB of memory
     disk_size=2048, # request a 2GiB of storage for the root disk for the container
     disk_type='SSD' # use an SSD for the root disk of the container
     # env={},     # field for parameters like config
     entrypoint='/sbin/my_init')
```

After creation, the container could be deployed.

```python
zos.workloads.deploy(container)

# inspect the result of the reservation provisioning
result = zos.workloads.get(workload_id)
```

The container workload deployment had the interactive flag set to True, which means the container did not start the entrypoint container bootstrap command. It has created a secure web interface to the coreX process where we could now manually enter the container and start and stop processes. Access is provided through http (as the connection is an encrypted wireguard tunnel).


```python
# See the coreX interface (should be empty)
https://172.20.30.11:7681/

# Start a bash shell through the coreX process manager
https://172.20.30.11:7681/api/process/start?arg[]=/bin/bash

# See the list of processes in coreX
https://172.20.30.11:7681/

# Click on the bash process to get shell access.
```