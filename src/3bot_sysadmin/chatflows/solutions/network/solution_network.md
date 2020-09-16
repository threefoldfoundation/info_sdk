# Network solution

This chatflow is used to deploy a network on the grid and to connect your solutions together.

To access it, go to your hosted 3Bot Admin Panel, and select __Network__.

## Inputs

The solution takes some configurations from the user, we will list them and explain their meaning

- `Network name` : A name for the network to deploy on and also to reference in the reservation manager.
- `IP version` : (IPv4 or IPv6) Version of the entrypoint node.
- `IP range` : Configure network manually by choosing an IP range to use or the deployer could choose for you and generate an IP range automatically.

## Chatflow steps

### Choose whether you want to create a new network or add access to an existing one

![Step1](./img/network_1.png)

### Choose the network name
![Step2](./img/network_2.png)

### Choosing how to reach the entrypoint node
To reach your solution on the grid you could use IPv6, problem is some countries don't have that infrastructure so we provide them access with an IPv4 entrypoint.
![Step3](./img/network_3.png)

### Searching for access node
![Step4](./img/network_4.png)

### The network IP Range
You can select an IP range for your solution to connect on.
![Step5](./img/network_5.png)

### Deploying your network
![Step6](./img/network_6.png)

### Wireguard install
Make sure you have Wireguard installed.
![Step7](./img/network_7.png)

### Wireguard configurations
While the grid is built around IPv6 you can still connect with IPv4 with Wireguard.

### Configuring your machine
Now you need to configure your machine to access the network by applying the wireguard configuration.
![Step8](./img/network_8.png)


## Access solution info from the network page
![Step9](./img/network_10.png)