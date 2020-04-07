<!--- Original conents: https://github.com/threefoldfoundation/info_threefold/edit/master/docs/wikieditors/installation_macos.md --->

## Local installation (MacOS)

### Prerequisites for the SDK installation.

In order to install the SDK in a container (recommended) you should have the docker software suite. You can find instructions for most operating systems [here](https://docs.docker.com/install/)

**Note** the latest release of docker desktop for macOS seems to have issues and the installer does not work for that.  If you have an older version of the docker Desktop the install might work.  Issue has been created and you can track it on [GitHub](https://github.com/threefoldtech/jumpscaleX_core/issues/672). 

If you still want to start on your mac we propose for now to use virtualbox and install an ubuntu server on it. you can find virtualbox [here](https://www.virtualbox.org/wiki/Downloads) and the ubuntu server image [here](https://ubuntu.com/download/server).  Once you have the virtual box VM with ubuntu servers you can follow the instructions to install the SDK [here](https://github.com/threefoldfoundation/info_threefold/blob/development/docs/wikieditors/installation_linux.md)

Also you need to have python installed on your machine.  For MacOS we recommend using the package manager [```brew```](https://brew.sh/), but there are regular installers for MacOS as well.  Here we assume that you have installed brew and install all the necessary packages:
```bash
brew install python3
```
After this finishes you can check the installation
```bash
$ brew info python3 
python: stable 3.7.7 (bottled), HEAD
... will output some info
```

And we need a gew additional libraries for the installation:

```bash
pip3 install click requests;
```

Then we need an sshkey to facilitate secure and easy access to the 3bot container.
```bash
# Load the ssh agent
eval `ssh-agent -s`
# Skip the ssh-keygen command in case you already have a ssh key for your root account.
ssh-keygen
# Adds private key identities to the OpenSSH authentication agent
ssh-add
# Show the public key that belongs to the loaded private key
ssh-add -L
```

The last command should show the public key
```bash
sh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC05P5eFki+5vHdn9BMrQwj0LZzl4FxwTAQ4GtwJFTS4Hog10Ly9sdhPQANOWASC1FXwZThVzj91hL8JCFuBZ5pDx29rJCDMQdqqVHQI5j8qkh4ZNNNQr/QLxdGl53RtQgabGe0OSn +ZdvGHuSQdTg03bomGrpCYcdsdsdsdsdnW0AHeMR0lEubbKMSQrTNCuZqrGbRPuxaHzWj9KQSe4xiRtA/PB7ccMsQlXeIh5pv8QI6k858oJzvlswczTgZivCKoHRnU6XyDVd60y9v3BpbB7YgTasw/VXUDt4oH7U61VI3Jy7t/d9jazMcDt3CngDtRpWQqZSO77 .ssh/id_rsa
root@happy:~# 
```

### Step 2:  TFGrid SDK installation

In a terminal execute the following commands. This will download the installer, change its permission to make it executable.  In MacOS this install can be done as a normal user, you do not need to be root (no sudo -i required as witht the ubuntu installation).
```
curl https://raw.githubusercontent.com/threefoldtech/jumpscaleX_core/development/install/jsx.py?$RANDOM > /tmp/jsx;
chmod +x /tmp/jsx;
```

This script provides a number of commands to operate / configure the SDK.  Options are show with the ```--help``` flag.

```bash
root@happy:~ /tmp/jsx --help
Usage: jsx [OPTIONS] COMMAND [ARGS]...

Options:
  --help  Show this message and exit.

Commands:
  basebuilder         create the base ubuntu docker which we can use as
                      base...
  check
  configure           initialize 3bot (JSX) environment
  connect             only for core developers and engineers of threefold,...
  container-delete    delete the 3bot container :param name: :return:
  container-export    export the 3bot to image file, if not specified will...
  container-import    import container from image file, if not specified...
  container-install   create the 3bot container and install jumpcale inside...
  container-kosmos    open a kosmos shell in container :param name: name of...
  container-save      starts from an export, if not there will do the
                      export...
  container-shell     open a shell to the container for 3bot :param name:...
  container-start     start the 3bot container :param name: :return:
  container-stop      stop the 3bot container :param name: :return:
  containers          list the containers :param name: :return:
  containers-reset    remove all docker containers & images :param name:...
  generate
  install             install jumpscale in the local system (only supported...
  jumpscale-code-get  install jumpscale in the local system (only supported...
  kosmos
  modules-install     install jumpscale module in local system :return:
  package-new         scaffold a new package tree structure
  sdk            jsx threebot -d :param delete: delete the containers...
  threebot-flist      create flist of 3bot docker image ex: jsx...
  threebotbuilder     create the 3bot and 3botdev images
  wiki-load
  wiki-reload         reload the changed files from wikis repo ex: jsx...
  wireguard           jsx wireguard enable wireguard, can be on host or...
```

## Install threebot
<!--
TODO #10 Content to add representing the Jumpscale SDK install

As the installation is not completing still needs to be finished when the install works.
-->
Then we can install our threebot using
```bash
# Make sure there are no remnissents from previous versions and installations.
/tmp/jsx containers-reset
# install tfgrid sdk
/tmp/jsx sdk
```