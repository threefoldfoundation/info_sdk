# 3sdk getting started

- [Get your 3bot words](#Get-your-3bot-words)
- [Basic Features](#Basic-Features)
  - [Start Threebot Container](#Start-Threebot-Container)
  - [Install New Container](#Install-New-Container)
  - [Running New Container](#Running-New-Container)
  - [Listing Containers](#Listing-Containers)
  - [Accessing Container Shell](#Accessing-Container-Shell)
  - [Getting Container Kosmos](#Getting-Container-Kosmos)
- [Advanced features](#Advanced-features)
  - [Controlling code branches](#Controlling-code-branches)

## Get your 3bot words

You will be asked the mnemonic words from your 3bot connect app during installation. Here is how to find them in the app:

- From 3botconnect application go to settings, then show phrase to get your mnemonics
- Take a note of the 3bot name and your email
- When registering for the first time you can use these private words in your configurations
- These words are needed, they are your private key.

## Show all the available commands

You can type `info` and you will see a list of available commands that you can use.

![info](3sdk_info.png)

## Basic Features

### Using the 3botconnect app words (mnemonics)

- You have to use same username & same email

### Start Threebot

The `threebot start` command is a helper command that will guide you through all the steps required to deploy your 3bot confiner.

```shell
3sdk> threebot start
Which network would you like to register to?
make your choice (mainnet,testnet,devnet,none): testnet
what is your threebot name (identity)?
example.3bot
Configured email for this identity is me@example.com
Copy the phrase from your 3bot Connect app here.
your words from your 3bot application need to be entered here
specify secret to encrypt your data:
specify secret to encrypt your data (confirm):
```

### Stop Threebot

`threebot stop`

## Advanced features

All the following commands will require you to start `3sdk` with `--expert` flag

### Install New Container

If you do not want to have the interactive wizrd, you can specify the different option manually too.

```shell
container install name=someuser identity=someuser email=someuser@gmail.com server=True
```

`server=True` means to start 3bot server.

### Listing Containers

You can list all the 3bot container installed on yout system using the `container list` command

```shell
3sdk> container list  

list the containers

 - notsomeuser3 : localhost       : threefoldtech/3bot2       (sshport:9000)
 - notsomeuser4 : localhost       : threefoldtech/3bot2       (sshport:9010)
 - 3bot       : localhost         : threefoldtech/3bot2       (sshport:9020)
3sdk>  
```

Using the `sshport` information you can do `ssh root@localhost -p $SSH_PORT` to manually ssh into the container.

### Start existing Container

To start an existing container:

```shell
container start name=mycontainer
```

### Accessing Container Shell

Either use the sshport info from `container list` command and `ssh root@localhost -p $SSH_PORT` or just execute `container shell` and optionally give it the name of your container

```shell
3sdk> container start name=3bot
```

### Getting Container Kosmos

Execute `container kosmos` to get into kosmos shell


### Controlling code branches

use `core branch` command to select which branch of the code to use to run your container.
you want to stop restart the container after switching branch to make sure all the processes inside have been properly updated with the new code.
