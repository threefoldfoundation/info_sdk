# Network solution

This package is used to deploy a network on the grid and to connect your solutions together.

## Accessing the solution

Go to your admin dashboard `https://localhost:4000/admin` and click on Network

![solutions menu](./adminmenu.png)


## Inputs

The solution takes some configurations from the user, we will list them and explain their meaning
- `Network name` : a name for the network to deploy on and also to reference in the reservation manager.
- `Payment currency`: a currency that will be used for the payment
- `Expiration time`: a network expiration time (minutes=m ,hour=h, day=d, week=w, month=M) is how long you want that solution to live on the grid
- `IP version` : (IPv4 or IPv6) Version of the entrypoint node.
- `IP range` : Configure network manually by choosing an IP range to use or the deployer can choose for you and generate an IP range automatically



## User setup

- register user threebot on explorer `kosmos "j.tools.threebot.init_my_threebot(name=3bot_NAME,email=EMAIL)"` **Note**: name of 3bot is (your 3bot name).3bot , email is your 3bot email
- Install [wireguard](https://www.wireguard.com/install/)


## Chatflow steps:

### Choosing the network name

![Step1](network1.png)
We choose the network name to be referenced again in the dashboard reservation manager

### Payment currency
![Step2](network2.png)
Choosing a currency that will be used for the payment

### Expiration time
![Step3](network3.png)
Choosing the expiration time for the network on the grid

### Choosing how to reach the entry point node
![Step4](network4.png)

To reach your solution on the grid you can use IP v6, problem is some countries don't have that infrastructure so we provide them access with an IP v4 entry point.

### The network IP Range
![Step5](network5.png)

We decide the IP range the network and all of the other solutions connected on it will operate on

### Wireguard install
![Step6](network6.png)
Just ask you to make sure you have Wireguard installed

### Wireguard configurations
![Step7](network7.png)
While the grid is built around IP v6 you need you to connected to the network, and that's done using wireguard.

### Configuring your machine
![Step8](network8.png)
Now you need to configure your machine to access the network by applying the wireguard configurations
