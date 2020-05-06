# This document shows how to setup/migrate your ThreeFold Farm and 3Nodes to TF Grid 2.0 (JSX Version)

**Summary**

- [Install 3SDK](#prerequisite-install-3sdk)
- [Create a new farm using the 3SDK GUI](#create-your-farm-using-the-3sdk-gui)
- [Create a new farm using the 3SDK kosmos shell](#create-your-farm-using-the-3sdk-kosmos-shell)
- [Generate a bootable 0-OS image](#create-a-bootable-image)
- [Start your node with the generated 0-OS image](http://localhost:3000/docs/grid/tf_farming/v2_jsx_farmsetup.html#start-3node-with-bootable-image)

This guide is splitted in two parts. One will show to use the 3SDK GUI to create a farm, the second part is using the SDK python shell.

If you need assistance contact ThreeFold support via the chat on www.threefold.io

### Please make sure you read the  [V2 Networking Document](https://github.com/threefoldtech/zos/blob/master/docs/network/introduction.md) before you start migrating your farm/nodes. 

## Prerequisite: Install 3SDK

See the installation instruction to get yourself the 3SDK installed: [https://sdk3.threefold.io/#/3sdk_install](https://sdk3.threefold.io/#/3sdk_install)

## Create your farm using the 3SDK GUI

When you have installed your 3SDK container, you should be able to access the web GUI at [https://localhost:4000](https://localhost:4000)

### 1. Choose your network

First things is to select the network you want to create your farm on. Most probably you want to use `mainnet`.
To select `mainnet`, click the `settings` tab on the bottom left, then select `Main` in the explorer dropdown input.

![network_choice](network_choice.png)

### 2. Install the farm management application

Next step is to install the farm management application. To do so, click the `Farm Management` tab on the left side menu.
Then click `Install required packages` button

![install_package](install_packages.png)

Once the package is installed, the page will reload the `farm management` UI will appear.

### 3. Create a TF Farm

To create a new farm, click the little plus button on the top left corner:

![add farm](add_farm.png)

It will open up a form to create a new Farm:

![new farm](new_farm.png)

Fill the form with your values. 

**Make sure you add a valid TFT stellar address. This is required in order for user to be able to reserve capacity from your farm.**

If you do not have a wallet yet. You can use the `Wallet Manger` from the 3SDK. You can find it in the left menu.

Once the farm is created you should see a new entry in the top table.

Notice the first colume of the table: ID. This is your farm ID, write this down cause you will need to use it when generating the 0-OS image for you the nodes of you farm.

![farm table](farm_table.png)

## Create your farm using the 3SDK kosmos shell

To enter kosmos shell just type `kosmos` in your 3SDK terminal

### 1. Choose your network

First things is to select the network you want to create your farm on. Most probably you want to use `mainnet`.

```python
j.clients.threebot.explorer_addr_set('explorer.grid.tf')
# j.clients.threebot.explorer_addr_set('explorer.testnet.grid.tf')  If you want to use testnet
```

### 2. Create a TF Farm

Now you can create a farm. To do so, we will use the Threefold Explorer client:

```python
# get a client to the explorer
explorer = j.clients.explorer.explorer
# create a new farm object
farm = explorer.farms.new()
# name your farm
farm.name = 'my_super_farm'
# link the farm with your identity
farm.threebot_id = j.me.tid
# Instruction below is only for farms which already exist in version 1.x and need to be migrated to version 2.0 !
# Specify the ItsYouOnline organization link to the farm
farm.iyo_organization = 'my_super_farm_v1'
# add your wallet address
wallet_address = farm.wallet_addresses.new()
wallet_address.asset = 'TFT'
wallet_address.address = 'GABONHE4AV6FFL57ZAYJXYSM7MHW5ONLYJE5F6O4ZADRUFGBFLHZWOGF'
# email address where farming result and any information for farmer will be sent.
farm.email = 'myname@gmail.com'
# actually register the farm on the grid
farm_id = explorer.farms.register(farm)
# print your farmer ID
print(farm_id)
```

If the last function succeeded, your farm is now created.
If you go to the explorer web UI you should be able to see your farm in "All farms" dropdown list.

## Create a bootable image

At this point you should have created your farm and noted its ID. The next step is to generate a bootable image of 0-OS to boot your nodes.

The bootstrap service: https://bootstrap.grid.tf is there for you to generate your 0-OS images.
In the bootstrap wizard, enter your farm ID, choose you network and download the generated image.
You are now ready to boot your nodes !

## Start 3Node with bootable image

After booting your 3Node it is visible on: [the tfgrid explorer](https://explorer.grid.tf)
