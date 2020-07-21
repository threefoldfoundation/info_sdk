# 3sdk getting started

## Get your 3Bot words

You will be asked the mnemonic words from your 3Bot connect app during installation. Here is how to find them in the app:

- From 3Botconnect application go to settings, then show phrase to get your mnemonics
- Take a note of the 3Bot name and your email
- When registering for the first time you can use these private words in your configurations
- These words are needed, they are your private key.


### Using the 3Botconnect app words (mnemonics)

- You have to use same username & same email

## Runnning 3bot

After the [installation](3sdk_install.md) steps you should have an executable `threebot`

- in case of pip it should be available for the user
- in case of poetry you need to be in the isolated environment using `poetry shell`

threebot server can run using `threebot start --local` starts a server on `8443, 8080`. If you want to use `80, 443` ports you need to set capabilities for nginx binary (in case of linux) or install as root in case of OSX

### Setting capabilities for nginx

```
sudo setcap cap_net_bind_service=+ep `which nginx`
```
to be able to run as a normal user, you don't need it if you are root.

- After that we will just do

  ```bash
  threebot start
  ```

- This will take you to configure your identity, It will ask you about your the network you want to use, 3bot name, email, and words.

- Then it will start threebot server you will see some thing like that

  ![configure](identity_new.png)

- After success you can visit the admin dashboard at http://localhost and start creating reservations

  ![configure](success.png)

## Stopping 3bot
You can stop threebot using `threebot stop`
