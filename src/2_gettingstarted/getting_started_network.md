# Getting started with the network

any solution you choose to deploy will need for you to provision an overlay network in order to reach the deployment.
we support both ipv4 and ipv6

If you are curious how the overlay network works, some documentation is available at [Overlay network](../3_smartcontract_for_it/capacity_network.md)


The technology used to implement the network overlay is [Wireguard](https://www.Wireguard.com/). Make sure you have installed Wireguard on your device to able to continue: [Wireguard installation](https://www.wireguard.com/install/)




## Network Solution

This chatflow is used to deploy a network on the grid and to connect your solutions together.

### Accessing the solution

Go to the marketplace https://marketplace.grid.tf/marketplace and click on Network

![solutions menu](./img/network_landing_page.png)


### Inputs

The solution takes some configurations from the user, we will list them and explain their meaning

- `Network name` : a name for the network to deploy on and also to reference in the reservation manager.
- `Payment currency`: a currency that will be used for the payment
- `Expiration time`: a network expiration time (minutes=m ,hour=h, day=d, week=w, month=M) is how long you want that solution to live on the grid
- `IP version` : (IPv4 or IPv6) Version of the entrypoint node.
- `IP range` : Configure network manually by choosing an IP range to use or the deployer can choose for you and generate an IP range automatically

### Chatflow steps

![Step1](./img/network_1.png)

#### Choosing the network name

![Step2](./img/network_2.png)

#### Expiration time

![Step3](./img/network_3.png)

Choose the expiration time of your reservation. Each capacity reservation made on the grid is always bound to an expiration date. Once the date is reached, the capacity is released back to the grid and your workloads deleted.



#### Select the farm you want to deploy on

![Step4](./img/network_4.png)
Choosing the expiration time for the network on the grid

#### The network IP Range

![Step5](./img/network_5.png)

We decide the IP range the network and all of the other solutions connected on it will operate on

#### Payment currency

![Step6](./img/network_10.png)
Choosing a currency that will be used for the payment

#### Choosing how to reach the entry point node

Here, the wizard asks to configure an `entrypoint` into your network so you can actually access your network from your device (laptop/PC/mobile). An `entrypoint` is responsible to route the traffic coming from your device to all the other nodes of the network.
The nodes running on the TFGrid all communicate over IPv6. While this is very convenient for the nodes, not everyone has access to IPv6 already. For this reason we allow people to configure `entrypoint` using IPv4 address.


You can choose between IPv6 or IPv4 for your `entrypoint`. If you are not sure what to choose, pick IPv4.



#### Wireguard install

![Step6](./img/network_8.png)
Just ask you to make sure you have Wireguard installed

#### Wireguard configurations

While the grid is built around IP v6 you need you to connected to the network, and that's done using wireguard.

#### Configuring your machine

![Step4](./img/network_7.png)
Now you need to configure your machine to access the network by applying the wireguard configurations
This screen shows you the configuration you need to download in order to configure your device. Just click the download button and save the configuration locally and configure you device.

Depending on your platform the configuration of Wireguard can look a bit different. But all the information required is shown in the configuration you have downloaded.



#### On Linux system

you can just use the `wg-quick` command directly with the file sent from the chatflow, like so:

```
wg-quick up my_first_network.conf
```

#### On MacOS

open the wireguard application and clock on the plus icon on the lower left corner. Add a new empty tunnel and copy the configuration or import the file if you have downloaded it from the chat flow.

![./img/wg_config_mac_add.png](./img/wg_config_mac_add.png)
![./img/wg_config_mac_config.png](./img/wg_config_mac_config.png)
![./img/wg_config_mac_enable.png](./img/wg_config_mac_enable.png)

#### On Windows

the process is very similar. Open the wireguard application and click on the plus icon on the lower left corner. Add a new empty tunnel and copy the configuration or import the file if you have downloaded it from the chat flow.

![./img/wg_config_win_add.png](./img/wg_config_win_add.png)
![./img/wg_config_win_config.png](./img/wg_config_win_config.png)
![./img/wg_config_win_enable.png](./img/wg_config_win_enable.png)

### Access solution info from the main screen

![Step5](./img/network_9.png)