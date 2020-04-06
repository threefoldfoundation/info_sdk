# Deploying a flist

A flist is the container deployed on zero-OS. 
It can be converted from Docker or customized on the [Zero-OS Hub](https://hub.grid.tf/).
The result can be uploaded and made available in the flist repository, where it is available for usage.  

## Deployment of a flist through the chatflow

Within the 3bot Admin console, a chatflow has been created to deploy a generic flist. 

![](./images/chatflow_flist0.png)

Through this chatflow, the flist is deployed into your local 3bot in a few simple steps : 
- Select the flist to be deployed
- Indicate public ssh key allowing to access the container through ssh
- Set environment variables (if needed) 
- Indicate whether the container needs to be accessible using a web browser
- Choose IPv4 vs IPv6
- Specify ip addresses
After this specification, the container will be deployed. 

To make it accessible, the following needs to happen: 
- Activate the network (using wireguard)
- Access the workload (using the specified ip address)
