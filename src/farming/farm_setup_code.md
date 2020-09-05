# Farm setup using Jumpscale code

This document shows how to setup/migrate your Threefold Farm and 3Nodes to TF Grid, not through chatflows but through Jumpscale code.
It is for people that have their 3Bot running on their local machine, by having set up the Jumpscale SDK, in the shell, and want to have more personalized DIY tooling for their farm than is available on the chatflow. 

If you need assistance contact Threefold support via the chat on www.Threefold.io .

## Create your farm using the JS-SDK poetry shell

To enter kosmos shell just type `poetry shell` in your SDK terminal

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
