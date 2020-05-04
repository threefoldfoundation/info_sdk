# Deploy your first solution

In this section we will guide you trough all the steps required to deploy your first workloads on the TFGrid.

We will start from scratch and guide you to the deployment of an ubuntu container.

This tutorial will use the example "chat flows" to deploy the solution. The chat flows are wizards that guide you through different steps asking you question to help you generate a reservation understandable by the grid.

If you are looking for some example how to do this programmatically, head to the [Develop](code.md) section.

## Index

1. [Register your identity on the TFGrid](#Register-your-identity-on-the-TFGrid)
2. [Install the 3SDK](#Install-the-3SDK)
3. [Get yourself some token](#Get-yourself-some-token)
4. [Deploy your private overlay network](#Deploy-your-private-overlay-network)
5. [Deploy an ubuntu container and connect to it](#Deploy-an-ubuntu-container-and-connect-to-it)

### Register your identity on the TFGrid

As a first step, you need to get yourself an identity. The identity system is based on some public/private key pair.

The easiest way to generate this identity is to download the **3Bot Connect** application on your smartphone.

The app can be found on the [Google Play store](https://play.google.com/store/apps/details?id=org.jimber.threebotlogin&hl=en) and [Apple Appstore](https://apps.apple.com/us/app/3bot-connect/id1459845885).

For a more detailed documentation about the installation and usage of the **3Bot Connect**, head to the dedicated section:

- [3Bot connect installation](3botconnect_install.md)
- [3Bot connect overview](3botconnect_overview.md)

### Install the 3SDK

#### Downloads the 3SDK binary

Now that you have an identity, the next step is to retrieve the 3sdk binary on your system.

You can find the binaries for GNU/Linux, macOS and Windows on the [release page of the github repository](https://github.com/threefoldtech/jumpscaleX_core/releases)

If you are hitting an issue or want to build from source, head to the full installation process documented at [3sdk_install](3sdk_install.md).

#### Start the 3SDK

Once you have the 3SDK binary available, you can now use it to start the installation process.

To do so, execute the 3SDK binary. This will open a shell in which plenty of actions are available to you. For this tutorial you only need to use one `container threebot`

After typing the command, a wizard will guide you through the rest of the installation process. (Complete documentation is once again available in the [associated section of the manual](3sdk_use.md))

After the full installation process is done, you should be able to reach the webUI of the 3SDK at [https://localhost:4000](https://localhost:4000)  and it should look like:

![dashboard.png](dashboard.png)

### Get yourself some token

The next step before we get to actually deployed workloads on the grid, is to get yourself some tokens.

At the time of writting, there are three types of tokens available:

- [FreeTFT](https://github.com/threefoldfoundation/tft-stellar/#freetft)
- [TFT](https://github.com/threefoldfoundation/tft-stellar/#tft)
- [TFTA](https://github.com/threefoldfoundation/tft-stellar/#tfta)

The FreeTFT's is a special token that has been created to allow developers and interested parties to play with the grid for free using free capacity by certain farmers.

Each user is eligible to get 1000 FreeTFT. To claim yours, head to [https://getfreetft.testnet.threefold.io](https://getfreetft.testnet.threefold.io).

To get yourself TFT, multiple options are possible, head to the [Tokens](tokens.md) section to know more.

### Deploy your private overlay network

You are not all set to start deploying workloads on the TFGrid. Yeah !

Before we get to deploy the actual ubuntu container, we first need to create a private overlay network. If you are curious how the overlay network works, some documentation is available at [Overlay network](capacity_network.md)

The technology used to implement the network overlay is [Wireguard](https://www.Wireguard.com/). Make sure you have installed Wireguard on your device to able to continue: [Wireguard installation](https://www.wireguard.com/install/)

For this tutorial we will use the network wizard that will guide use through the creation of your network.

To start the wizard click the left menu on Solutions then Network

![solutions menu](adminmenu.png)

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


On Linux system, you can just use the `wg-quick` command directly with the file sent from the chatflow, like so:

```
wg-quick up my_first_network.conf
```

On MacOS, open the wireguard application and clock on the plus icon on the lower left corner. You can or add a new empty tunnel and copy the configuration or import the file if you have downloaded it from the chat flow.

![wg_config_mac_add.png](wg_config_mac_add.png)
![wg_config_mac_config.png](wg_config_mac_config.png)
![wg_config_mac_enable.png](wg_config_mac_enable.png)

On Windows the process is very similar. Open the wireguard application and click on the plus icon on the lower left corner. You can or add a new empty tunnel and copy the configuration or import the file if you have downloaded it from the chat flow.

![wg_config_win_add.png](wg_config_win_add.png)
![wg_config_win_config.png](wg_config_win_config.png)
![wg_config_win_enable.png](wg_config_win_enable.png)

### Deploy an ubuntu container and connect to it

Now that you have a network in place. We can deploy containers and connect it to the network. To do so we will use the ubuntu Chat flow

To start the wizard click the left menu on Solutions then Ubuntu

![solutions menu](adminmenu.png)

1. First step to deploy ubuntu is to choose the network on which you want to deploy your Ubuntu container. Use the same name you entered previously when creating the network

![step2](ubuntu_network.png)

2. Second enter a name to give your ubuntu solution. This will be used locally to save the details of the deployment.

    ![step3](ubuntu_solution.png)

3. Next choose the version of Ubuntu on you want. We currently support versions 18.04 and 16.04
    ![step4](ubuntu_version.png)

4. Then choose how much CPU and Memory resources you want allocated for the container
    ![step5](ubuntu_resources.png)

5. In order to access this container after it is deployed, you will need to upload your public ssh key. Usually your public and private ssh key pairs are found in `~/.ssh` where the public key ends in `.pub`

    ![step6](ubuntu_sshkey.png)

6. The next step is to choose the expiration time of your ubuntu reservation. Each capacity reservation made on the grid is always bound to an expiration date. Once the date is reached, the capacity is released back to the grid and your workloads deleted.

    For this tutorial one day will be more then enough.

    ![step8](ubuntu_expiration.png)

7. After that you will encounter an optional question asking for a node ID to deploy the container on. If there is a specific node you want your container to be on then provide its ID otherwise leave it empty. To discover nodes where to deploy your solution the easiest place to look for them is the explorer: https://explorer.grid.tf

    ![step8](ubuntu_nodeid.png)

8. If you left the nodeid empty, you can then choose the farms on which the container can be deployed on. The farms are basically a group of nodes where multiple solutions can be deployed on them. You can either choose the farm name from the drop down list or leave it empty to randomly choose any farm.

    ![step8](ubuntu_farms2.png)

9. You can now choose an IP address that will be given to your ubuntu container in your network. This is the ip address you will be using to access the container.

    ![step9](ubuntu_ip.png)

10. Then read carefully the options you selected previously until this point in the chatflow and confirm them by clicking next to proceed with.

    ![step10](ubuntu_overview.png)

11. Now that you have chosen all the resources and details required, you will need to proceed with the payment for the solution that will be deployed. As previously mentioned, you will have your wallet setup and funded with an amount of the currency you chose your network with. The following overview will show the price of the deployment and the details regarding the address to be payed to. By clicking on the wallet you will pay with and then next then you accept the payment to be automatically done from it.

    ![step10](ubuntu_payments.png)

12. Once the amount is available in the wallet and the payment is successfully complete, the deployment process is continued. After the deployment is successful which may take a couple of minutes sometimes, the following message is shown with details regarding the reservation id which is a unique id used for your specific container deployment. It also views the ip address that is to be used to connect to the container.

    ![step11](ubuntu_success.png)

13. You can now simply access the deployed ubuntu container by the following command

    ```bash
    ssh root@IP_ADDRESS
    ```

    where the ip address is the one you chose in the chatflow earlier and is shown in the previous success message.

You can view _all_ your deployed solutions that haven't expired such as the network and the ubuntu container you created by clicking the left menu on **Deployed Solutions**.
![step11](deployed_solutions.png)
