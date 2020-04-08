## Deploy a generic flist

#### Requirements

In order to be able to deploy this example deployment you will have to have the following components activated
- the Jumpscale SDK, in the form of a local container with the SDK, or a grid based SDK container.  Getting started instuctions are [here](https://github.com/threefoldfoundation/info_projectX/tree/development/doc/jumpscale_SDK) 
- if you use a locally installed container with the 3bot SDK you need to have the wireguard software installed.  Instructions to how to get his installed on your platform can be found [here](https://www.wireguard.com/install/)
- capacity reservation are not free so you will need to have some ThreeFold Tokens (TFT) to play around with.  Instructions to get tokens can be found [here](https://github.com/threefoldfoundation/info_projectX/blob/development/doc/jumpscale_SDK_information/payment/FreeTFT_testtoken.md)

After following these install instructions you should end up having a local, working jumpscale SDK installed.  You can work / connect to the installed SDK as described [here](https://github.com/threefoldfoundation/info_projectX/blob/development/doc/jumpscale_SDK/SDK_getting_started.md)

### Overview
The design a simple kubernetes cluster we need to follow a few steps:
- create (or identify and use) an overlay network that spans all of the nodes needed in the solution
- identify which nodes are involved in the kubernetes cluster, master and worker nodes
- create reservations for the kubernetes virtual machines.
- deploy the kubernetes cluster.

#### Create overlay network of identity an previously deployed overlay network

Each overlay network is private and contains private IP addresses.  Each overlay network is deployed in such a way that is has no connection to the public (IPv4 or IPv6) network directly.  In order to work with such a network a tunnel needs to be created between the overlay network on the grid and your local network.  You can find instructions how to do that [here](https://github.com/threefoldfoundation/info_projectX/blob/development/doc/jumpscale_SDK_examples/network/overlay_network.md)

#### Set up the capacity environment to find, reserve and configure

Make sure that your SDK points to the mainnet explorer for deploying this capacity example.  Also make sure you have an identity loaded.  The example code uses the default identity.  Multiple identities can be stored in the jumpscale SDK.  To check your available identities you can request the number of identities available for you by typing `j.tools.threebot.me` in the kosmos shell.



```python
j.clients.explorer.default_addr_set('explorer.grid.tf')

# Which identities are available in you SDK
j.tools.threebot.me

# Make sure I have an identity (set default one for mainnet of testnet)
me = j.tools.threebot.me.default

# Load the zero-os sal and reate empty reservation method
zos = j.sal.zosv2
r = zos.reservation_create()
```

#### What is an flist?  

An flist is a very special container images.  One of the challenges with industry leading technologies like docker and kubernetes is that every node involved in an IT architecture has to have local copies of all of the images it needs to run as containers. These can either be base images on which specific modifications need to be made or they are specific images downloaded from the docker hub or a private image repository (enterprise use cases).  Having these images exists on many different nodes requires these to be downloaded and maintained for version control and bug fixes.  This is waistfull (many times the same image required storage space) and time consuming. 

The flist solves that issue by facilitating container images to be made available on fly to nodes that needs the content of a container image over the network from a so called hub.  There is a public hub that serves images but the hub facility is open source and can be replicated for private or corporate usage.  The hub can be found here: `http://hub.grid.tf`.

The flist represents a very efficient way to distribute de-duped container image with a bandwidth optmised transfer process and increased security by signed files.  For (a lot) more details please go here:

 * generic description [here](https://github.com/threefoldtech/0-flist/blob/development/doc/flist.md)
 * GitHub repository [here](https://github.com/threefoldtech/0-flist)
 * FreeFlow pages [article](http://freeflowpages.com/content/perma?id=9396)
    
On the public hub there is import functionality to import docker images and create flists out of them. Another way to create your own tar archives and upload these to transform into flists.  More information with regards to creating, managing and using flists can be found [here](https://hub.grid.tf/)

#### Select which flist to deploy?

For this example we selected the code-server flist in public hub.  The code-server flist is based on an open opensource software managed here: https://github.com/Microsoft/vscode.  Its visual studio code providing a very feature rich coding and code management environment.  The flist can be found [here](https://hub.grid.tf/weynandkuijpers.3bot/codercom-code-server-latest.flist).

#### Node selection and parameters.
You have created a network in the network creation [notebook](https://github.com/threefoldfoundation/info_projectX/blob/development/code/jupyter/SDK_examples/network/overlay_network.ipynb) with the following details:

```python
demo_ip_range="172.20.0.0/16"
demo_port=8030
demo_network_name="demo_network_name_01"
```
When you executed the reservation it also provided you with data on order number, node ID and private network range on the node.  All the nodes in the network are connected peer2peer with a wireguard tunnel.  On these nodes we can now launch the flist.  For this solution we will be using some of these nodes as master nodes and others as worker nodes.  Using the ouput of the network reservation notebook to describe the high level design of the kubernetes cluster:

| Nr.  |  Location | Node ID.   |  IPV4 network    | Function.  |
|--------|---|---|---|---|
|    1    | Salzburg  | 9kcLeTuseybGHGWw2YXvdu4kk2jZzyZCaCHV9t6Axqqx  | 172.20.15.0/24  | Available |
|    2    | Salzburg  | 3h4TKp11bNWjb2UemgrVwayuPnYcs2M1bccXvi3jPR2Y  | 172.20.16.0/24  |  Available |
|    3    | Salzburg  |  FUq4Sz7CdafZYV2qJmTe3Rs4U4fxtJFcnV6mPNgGbmRg | 172.20.17.0/24  | Available|
|    4    | Vienna  |  9LmpYPBhnrL9VrboNmycJoGfGDjuaMNGsGQKeqrUMSii | 172.20.28.0/24  |  Available |
|    5    | Vienna  |  3FPB4fPoxw8WMHsqdLHamfXAdUrcRwdZY7hxsFQt3odL | 172.20.29.0/24  | Available  |
|    6    | Vienna  |  CrgLXq3w2Pavr7XrVA7HweH6LJvLWnKPwUbttcNNgJX7 | 172.20.30.0/24  | Available  |


The reservation for a general purpose flist has the following structure
```python
zos.container.create(reservation=r,
                    node_id=string,             # node_id to make the capacity reservation on and deploy the flist
                    network_name=string,        # network_name deployed on the node (node can have multiple private networks)
                    ip_address=string,          # one IP address in the range of the chosen network_name on the node
                    flist=string,               # flist of the container you want to install, htttp hub location.
                    interactive=Bolean,         # True of False. When True the entrypoint start commend is ignored and a web interface to the coreX process will de started instead
                    cpu=integer,                # number of logical cores
                    memory=interger,            # number of mBs of memory
                  # env={},                     # field for parameters like needed in the container environment 
                    entrypoint=string)          # start command to get the software running in the container
```

For more details and options please see [here](https://github.com/threefoldtech/jumpscaleX_libs/blob/master/JumpscaleLibs/sal/zosv2/container.py)

Provinding the corect detais allows us to deploy the code-server container.


```python
r = zos.reservation_create()

# Add data to method to what to deploy.  Example is code server
zos.container.create(reservation=r,
                    node_id='CrgLXq3w2Pavr7XrVA7HweH6LJvLWnKPwUbttcNNgJX7', # one of the node_id that is part of the network
                    network_name=u_networkname, # this assume this network is already provisioned on the node
                    ip_address='172.20.30.11', # part of ip_range you reserved for your network xxx.xxx.1.10
                    flist='https://hub.grid.tf/weynandkuijpers.3bot/codercom-code-server-latest.flist', # flist of the container you want to install
                    interactive=True,         # True only if corex_connect required, default false
                    cpu=4,
                    memory=4196,
                  # env={},                   # field for parameters like config 
                    entrypoint='/sbin/my_init')
```

Having defined registration structure `r` we can now deploy.  In this example we deploy for 5 minutes (adapt if required


```python
# methods needed to do time calculations
import time

# reserve until now + (x) seconds
expiration = j.data.time.epoch + (5*60)
# register the reservation
rid = zos.reservation_register(r, expiration, identity=me)
time.sleep(5)

# inspect the result of the reservation provisioning
result = zos.reservation_result(rid)
```

The reservation had the interactive flag set to True which means the container did not start the entrypoint container bootstrap command.  It has created a secure web interface to the corX process where we can now manualy enter the container and start and stop processes. Access is provided through http (as the connection is an encrypted wireguard tunnel).


```python
# See the coreX interface (should be empty)
https://172.20.30.11:7681/
        
# Start a bash shell through the coreX process manager
https://172.20.30.11:7681/api/process/start?arg[]=/bin/bash
        
# See the list of processes in coreX
https://172.20.30.11:7681/
        
# Click on the bash process to get shell access.
```
