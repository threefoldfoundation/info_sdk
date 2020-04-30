# Deploy your first solution

In this section we will guide you trough all the steps required to deploy your first workloads on the TFGrid.

We will start from scratch and guide you to the deployment of an ubuntu container.

## Index

1. Register your identity on the TFGrid
2. Install the 3SDK
3. Get yourself some token
4. Deploy your private overlay network
5. Deploy an ubuntu container and connect to it

### Register your identity on the TFGrid

As a first step, you need to get yourself an identity. The identity system is based on some public/private key pair.

The easiest way to generate this identity is to download the **3Bot Connect** application on your smartphone.

The app can be found on the [Google Play store](https://play.google.com/store/apps/details?id=org.jimber.threebotlogin&hl=en) and [Apple Appstore](https://apps.apple.com/us/app/3bot-connect/id1459845885).

For a more detail documentation about the installation and usage of the **3Bot Connect**, head to the dedicated section:

- [3Bot connect installation](3botconnect_install.md)
- [3Bot connect overview](3botconnect_overview.md)

### Install the 3SDK

#### Downloads the 3SDK binary

Now that you have an identity, the next step is to retrieve the 3sdk binary on your system.

You can find the binaries for GNU/Linux, macOS and Windows on the [release page of the github repository](https://github.com/threefoldtech/jumpscaleX_core/releases)

If you are hitting issue or want to build from source, head to the full installation process is documented at [3sdk_install](3sdk_install.md).

#### Start the 3SDK

Once you have the 3SDK binary available, you can now use it to start the installation process.

To do so, execute the 3SDK binary. This will open a shell in which plenty of actions are available to you. For this tutorial you only need to use one `container threebot`

After typing the command, a wizard will guide you through the rest of the installation process. (Complete documentation is once again available in the [associated section of the manual](3sdk_use.md))

After the full installation process is done, you should be able to reach the webUI of the 3SDK at [https://localhost:4000](https://localhost:4000)  and it should look like:

![dashboard.png](dashboard.png)

### Get yourself some token

The next step before we get to actually deployed workloads on the grid, is to get yourself some tokens.

At the time of writting, there are three type of token available:

- [FreeTFT](https://github.com/threefoldfoundation/tft-stellar/#freetft)
- [TFT](https://github.com/threefoldfoundation/tft-stellar/#tft)
- [TFTA](https://github.com/threefoldfoundation/tft-stellar/#tfta)

The FreeTFT's is a special token that has been created to allow developers and interested parties to play with the grid for free using free capacity by certain farmers.

Each user is eligible to get 1000 FreeTFT. To claim yours, head to [https://getfreetft.testnet.threefold.io](https://getfreetft.testnet.threefold.io).

To get yourself TFT, multiple options are possible, head to the [Tokens](tokens.md) section to know more.

### Deploy your private overlay network

You are not all set to start deploying workloads on the TFGrid. Yeah !

Before we get to deploy the actual ubuntu container, we first needs to create a private overlay network. If you are curious how the overlay network works, some documentation is available at [Overlay network](capacity_network.md)

The technology used to implement the network overlay is [Wireguard](https://www.Wireguard.com/). Make sure you have installed Wireguard on your device to able to continue: [Wireguard installation](https://www.wireguard.com/install/)

For this tutorial we will use the network wizard that will guide use through the creation of your network.

To start the wizard click the left menu on Solutions then Network

![solutions menu](adminmenu2.png)

First step is to choose the name of your network. This name is only used to identity the network later on when deploying workloads.

![choose network name](network_choose_name.png)

Second step is to choose the expiration time of your reservation. Each capacity reservation made on the grid is always bound to an expiration date. Once the date is reached, the capacity is released back to the grid and your workloads deleted.

For this tutorial one day will be more then enough.

![choose network expiration](network_choose_expiration.png)

Third step is to configure an `entrypoint` into your network so you can actually access your network from your device (laptop/PC/mobile). An `entrypoint` is responsible to route the traffic coming from your device to all the other nodes of the network.

The node running on the TFGrid all communicate over IPv6. While this is very convenient for the nodes, not everyone has access to IPv6 already. For this reason we allow people to configure `entrypoint` using IPv4 address.

The third step let you choose between IPv6 or IPv4 for your `entrypoint`. If you are not sure what to choose, pick IPv4.

![choose entrypoint type](network_choose_entrypoint.png)

Fourth step is there to let you configure the subnet used by your network. To make it easy here we just let the wizard pick one for us.

![choose network subnet](network_choose_iprange.png)

Fifth step shows you the configuration you need to download in order to configure your device. Just click the download button and save the configuration locally and configure you device.

Depending on your platform the configuration of Wireguard can look a bit different. But all the information required are show in the configuration you have downloaded.

![Step6](network_wgconfig.png)

### Deploy an ubuntu container and connect to it

Now that you have a network in place. We can deploy containers and connect it to the network. To do so we will use the ubuntu Chat flow