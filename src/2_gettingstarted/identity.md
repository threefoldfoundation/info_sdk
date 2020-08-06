# Identities

## Creating/registering new identities using the sdk

### When starting threebot for the first time

- After installing the sdk successfully, when starting threebot server using the following commands, you will be prompted to enter the required information to setup an initial default identity which includes the explorer url to be used
  
  ```bash
  threebot start
  ```

- This will take you to configure your identity, It will ask you about the network you want to use, 3bot name, email, and words.
    
    ![configure](./img/identity_new.png)

- Then it will start threebot server with an identity setup that can be accessed via `j.core.identity.me`


### Manual configuration of identity

Further identities can also be added from the jsng shell as follows
- Create a new identity instance
```
identity = j.core.identity.new(name="INSTANCE_NAME",tname="THREEBOT_NAME.3bot", email="THREEBOT_EMAIL", words="WORDS",explorer_url="https://explorer.testnet.grid.tf/explorer")
```
where
  - **INSTANCE_NAME**: is the instance name of the identity that will be configured
  - **THREEBOT_NAME**: 3bot name registered from 3bot connect app (should be in the form `NAME.3bot`)
  - **THREEBOT_EMAIL**:  corresponding email for the 3bot name from 3bot connect app 
  - **WORDS**: words that can be retrieved from the 3bot connect app settings
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

New identities can be added through the admin dashboard once threebot server is started.
- Access settings of `httpa://<host>/admin` and click on the `ADD` button on the identities
![identity_list](./img/identity_list.png)

- Add the threebot name,email, words, and explorer type in the window prompted then click on `Add` to create and register the identity intance
![new identity](identity_new_dashboard.png)


## Change default identity

When you have multiple identities setup and want to switch the usage between them, this can simply be done using 
- jsng shell
```
j.core.identity.set_default("INSTANCE_NAME") 
```
where
    - **INSTANCE_NAME**: is the instance name of the identity previously created and registered

- Admin dashboard

    When clicking on the identity intance then the `SET DEFAULT` button, that instane will be the current default intance used

    ![set default identity](identity_buttons.png)


