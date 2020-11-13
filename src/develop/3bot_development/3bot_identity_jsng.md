# Identities

## Creating/registering new identities using the jsng shell

### When starting 3Bot for the first time

- After installing the sdk successfully, when starting 3Bot server using the following commands, you will be prompted to enter the required information to setup an initial default identity which includes the explorer url to be used
 
 ```bash
  threebot start
 ```

- This will take you to configure your identity, It will ask you about the network you want to use, 3Bot name, email, and words.
 
 ![configure](./img/identity_new.png)

- Then it will start 3Bot server with an identity setup that could be accessed via `j.core.identity.me`


### Manual configuration of identity

Further identities could also be added from the jsng shell as follows
- Create a new identity instance
```
identity = j.core.identity.new(name="INSTANCE_NAME",tname="THREEBOT_NAME.3bot", email="THREEBOT_EMAIL", words="WORDS",explorer_url="https://explorer.testnet.grid.tf/explorer")
```
where
 - **INSTANCE_NAME**: is the instance name of the identity that will be configured
 - **THREEBOT_NAME**: 3Bot name registered from ThreeFold Connect app (should be in the form `NAME.3bot`)
 - **THREEBOT_EMAIL**: corresponding email for the 3Bot name from ThreeFold Connect app 
 - **WORDS**: words that could be retrieved from the ThreeFold Connect app settings
 - **explorer_url**: explorer grid url that is to be used. Should be one of the following:
 - Mainnet: `https://explorer.grid.tf/explorer`
 - Testnet: `https://explorer.testnet.grid.tf/explorer`

- Register/retrieved registered identity

 You will then need to register the new identity to the grid corresponding to the explorer url in the instance. If the identity name and email combination already exist on the explorer, the details are simply retrieved which include the tid.

 To register and save the identity:
```
identity.register()
identity.save()
```
 The identity will now have a tid in the instance

### Using admin dashboard

see [3bot_identity_configure](3bot_identity_configure)

## Change default identity

When you have multiple identities setup and want to switch the usage between them, this could simply be done using 
- jsng shell
```
j.core.identity.set_default("INSTANCE_NAME") 
```

where

- **INSTANCE_NAME**: is the instance name of the identity previously created and registered



