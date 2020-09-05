# This document shows how to setup/migrate your Threefold Farm and 3Nodes to TF Grid 2.2 (js-ng 11.0.0.alpha1)

**Summary**

- [Install 3SDK](#prerequisite-install-3sdk)
- [Create a new farm using the 3SDK GUI](#create-your-farm-using-the-3sdk-gui)
- [Create a new farm using the 3SDK kosmos shell](#create-your-farm-using-the-3sdk-kosmos-shell)
- [Generate a bootable 0-OS image](#create-a-bootable-image)
- [Start your node with the generated 0-OS image](http://localhost:3000/docs/grid/tf_farming/v2_jsx_farmsetup.html#start-3Node-with-bootable-image)

This guide is splitted in two parts. One will show to use the 3SDK GUI to create a farm, the second part is using the SDK python shell.

If you need assistance contact Threefold support via the chat on www.Threefold.io

### Please make sure you read the [V2 Networking Document](https://github.com/Threefoldtech/zos/blob/master/docs/network/introduction.md) before you start migrating your farm/nodes. 

## Prerequisite: Install 3SDK

See the installation instruction to get yourself the 3SDK installed: [https://manual.Threefold.io/#/3sdk_install](https://manual.Threefold.io/#/3sdk_install)

## Create your farm using the 3SDK GUI

When you have installed your 3SDK, you should be able to access the web GUI at [https://localhost/admin](https://localhost/admin)

### 1. Choose your network using identities

First things is to select the identity with the network you want to create your farm on. Most probably you want to use `mainnet`.
To check the explorer instance of your identity, click on the `settings` tab and click on the current identity to see the explorer url of it.
Testnet url refers to `https://explorer.testnet.grid.tf`, mainnet url refers to `https://explorer.grid.tf`. 

![identity_list](./img/identity_list.png)
![identity_details](./img/identity_details.png)

If you want to switch to a different identity you could create a new one from the `ADD` button on the identities tab where you need to provide the secret words from your 3Bot connect app to get a registered identity and you could choose the explorer type corresponding to the network you need. For `mainnet` you could choose `Main network`.

![new_identity_form](./img/new_identity_form.png)

### 2. Install the farm management application

Next step is to install the farm management application. To do so, click the `Farm Management` tab on the left side menu.
Then click `Install required packages` button

![install_package](./img/install_packages.png)

Once the package is installed, the page will reload the `farm management` UI will appear.

### 3. Create a TF Farm

To create a new farm, click the little plus button on the top left corner:

![add farm](./img/add_farm.png)

It will open up a form to create a new Farm:

![new farm](./img/new_farm.png)

Fill the form with your values. 

**Make sure you add a valid TFT stellar address. This is required in order for user to be able to reserve capacity from your farm.**

Copy the address of the Stellar account from your 3Bot Connect app, where you could copy it from the wallet in the info tab on the detail screen of your farmer wallet.

![detail_3bot](./img/detail_3bot_connect.png)

A wallet also could be created or imported from your 3Bot Connect app in `Wallet Manager` in the sdk admin. Handy for having all at hand, required for reserving capacity. 


![wallet_in_jsng](./img/wallet_in_jsng.png)

Once the farm is created you should see a new entry in the top table.

Notice the first colume of the table: ID. This is your farm ID, write this down cause you will need to use it when generating the 0-OS image for you the nodes of you farm.

![farm table](./img/farm_table.png)

## Create your farm using the 3SDK kosmos shell

To enter kosmos shell just type `kosmos` in your 3SDK terminal

### 1. Choose your network using identity

First things is to select the identity containing the network you want to create your farm on. Most probably you want to use `mainnet`. You could do that by clicking on the `SET DEFAULT` button on the form showing the identity details in the `Settings`

![identity_buttons](./img/identity_buttons.png)

You could also set the default identity to be used from the js-ng shell

```python
j.core.identity.set_default("identity_instance_name")
# This identity could now be accessed using j.core.identity.me
```

### 2. Create a TF Farm

Now you could create a farm. To do so, we will use the Threefold Explorer client:

```python
from jumpscale.clients.explorer.models import TF GridDirectoryWallet_address1      

# get a client to the explorer
explorer = j.core.identity.me.explorer
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
wallet_address = TF GridDirectoryWallet_address1()
wallet_address.asset = 'TFT'
wallet_address.address = 'GABONHE4AV6FFL57ZAYJXYSM7MHW5ONLYJE5F6O4ZADRUFGBFLHZWOGF'
farm.wallet_addresses.append(wallet_address)

# email address where farming result and any information for farmer will be sent.
farm.email = 'myname@gmail.com'
# actually register the farm on the grid
farm_id = explorer.farms.register(farm)

# save the farm instance created
farm.save()
# print your farmer ID
print(farm_id)
```

If the register function succeeded, your farm is now created and you could save it and proceed.
If you go to the explorer web UI you should be able to see your farm in "All farms" dropdown list.

## Create a bootable image

At this point you should have created your farm and noted its ID. The next step is to generate a bootable image of 0-OS to boot your nodes.

The bootstrap service: https://bootstrap.grid.tf is there for you to generate your 0-OS images.
In the bootstrap wizard, enter your farm ID, choose you network and download the generated image.
You are now ready to boot your nodes !

## Start 3Node with bootable image

After booting your 3Node it is visible on: [the TF Grid explorer](https://explorer.grid.tf)
