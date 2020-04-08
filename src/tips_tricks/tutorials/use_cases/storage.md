# Deploying S3 Storage Capacity
## Deployment of S3 Storage Capacity through the chatflow

Within the 3bot Admin console, a chatflow has been created to reserve S3 storage capacity. 
This storage can be dispersed over different nodes. 

![](./images/minio_chatflow1.png)

Through this chatflow, S3 storage is reserved and configured simply by collection of a number of parameters : 
- IPv4 vs. IPv6
- Password to be used for the 0-db storage
- Disk type : SSD or HDD
- Mode : user or sequential
- Minio login key
- Secret to match the previous key
- Amount of CPUs needed
- Memory size needed (in GB)
- Number of data drives to be used for spreading the data
- Number of parity drives
- Network definition (existing or new)
- If new network : IP range to be used (self-selected or generated)
- Network name (in case network is meant to be reused)
- IP address to access the storage

This information is sufficient to create the workload on the network.

![](./images/minio_chatflow17.png)


The network might yet be set up, using Wireguard.
For ubuntu machines, you get command line instruction: 
![](./images/minio_chatflow17.png)


On MacOS, the Wireguard configuration can be set up through the Wireguard application : 
- Download the configuration into a file
![](./images/minio_chatflow19.png)


- load this into Wireguard tunnel 
![](./images/minio_chatflow20.png)

Finally, the location of the workload is shown : 
![](./images/minio_chatflow21.png)


## How to set up S3 Storage using the Jupyter Notebooks?
In the Navbar you will find the section "NEED THE NAME" that has pre-made notebooks. These will guide you through all the steps you need to take to setup a network, but do not limit you when it comes to parameter as you can edit the scripts as you go.

## How to set up S3 Storage using the CodeServer?
Within the SDK you'll find the CodeServer in the left hand navbar.
In here you will find all files and code you need to set up a network and have total control over it, set your parameters, choose your nodes, etc.
