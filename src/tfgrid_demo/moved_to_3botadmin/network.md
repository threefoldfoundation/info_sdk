# Network solution

This chatflow is used to deploy a network on the grid and to connect your solutions together.

To access it, go to [TF Grid Demo Testnet 2.2](https://marketplace-testnet.grid.tf/) and select Network

## Inputs

The solution takes some configurations from the user, we will list them and explain their meaning

- `Network name` : a name for the network to deploy on and also to reference in the reservation manager.
- `IP version` : (IPv4 or IPv6) Version of the entrypoint node.
- `IP range` : Configure network manually by choosing an IP range to use or the deployer could choose for you and generate an IP range automatically

## Chatflow steps

### Choose whether you want to create a new network or add access to an existing one

![Step1](./img/network_1.png)

### Choose the network name
![Step2](./img/network_2.png)

### Choosing how to reach the entry point node
To reach your solution on the grid you could use IP v6, problem is some countries don't have that infrastructure so we provide them access with an IP v4 entry point.
![Step3](./img/network_3.png)

### Searching for access node
![Step4](./img/network_4.png)

### The network IP Range
We decide the IP range the network and all of the other solutions connected on it will operate on
![Step5](./img/network_5.png)

### Deploying your network
![Step6](./img/network_6.png)

### Wireguard install
Just ask you to make sure you have Wireguard installed
![Step7](./img/network_7.png)

### Wireguard configurations
While the grid is built around IPv6 you need you to be connected to the network, and that's done using wireguard. Replace the path of the file with the one you downloaded the config in.
![Step8](./img/network_8.png)

### Configuring your machine
Now you need to configure your machine to access the network by applying the wireguard configurations
![Step9](./img/network_9.png)

## Access solution info from the network page
![Step9](./img/network_10.png)