# Ubuntu
A free and open-source Linux distribution based on Debian.
Ubuntu is officially released in three editions: Desktop, Server, and Core(for internet of things devices and robots). This package is used to deploy a Ubuntu container from an official Flist on the grid using a chatflow.

### You need to create a pool and a network first before deploying your ubuntu container

# Steps to deploy solution

### Add the solution name. Keep in mind it will also be the subdomain.
![](./img/ubuntu_1.png)

### Choose your ubuntu version
![](./img/ubuntu_2.png)

### Choose container resources
Here we specify the CPU and Memory resources allocated for the container
![](./img/ubuntu_3.png)

### Select a pool for your solution
![](./img/ubuntu_4.png)

### Choose a network
![](./img/ubuntu_5.png)

### Choose whether you want to push the container logs onto an external redis channel or not
![](./img/ubuntu_6.png)

### Access keys
Uploading your public key for SSH access
![](./img/ubuntu_7.png)

### Select node or leave it empty
Here we could provide a node id corresponding to a current node on the grid to deploy the container on. If there is no specific node to be used then it is left empty.
![](./img/ubuntu_8.png)

### Choosing private IP
![](./img/ubuntu_9.png)

### Choose whether you want to assign a global Ipv6 address for your container or not
![](./img/ubuntu_10.png)

### Confirmation
Here we confirm the specifications we entered in the chatflow
![](./img/ubuntu_11.png)

### Deploying your solution
![](./img/ubuntu_12.png)

### Deployment successful, you could ssh into your container now using ip address.
![](./img/ubuntu_13.png)