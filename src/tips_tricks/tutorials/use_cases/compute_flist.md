# Deploying a Flist

A Flist is the container deployed on zero-OS. 
It could be converted from Docker or customized on the [Zero-OS Hub](https://hub.grid.tf/).
The result could be uploaded and made available in the Flist repository, where it is available for usage. 

## Deployment of a Flist through the chatflow

Within the 3Bot Admin console, a chatflow has been created to deploy a generic Flist. 

![](./img/chatflow_Flist0.png)

Through this chatflow, the Flist is deployed into your local 3Bot in a few simple steps : 
- Select the Flist to be deployed
- Indicate public ssh key allowing to access the container through ssh
- Set environment variables (if needed) 
- Indicate whether the container needs to be accessible using a web browser
- Choose IPv4 vs IPv6
- Specify IP addresses
After this specification, the container will be deployed. 

To make it accessible, the following needs to happen: 
- Activate the network (using wireguard)
- Access the workload (using the specified IP address)


