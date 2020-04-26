# JumpscaleX Installation Instructions

<!--
TODO Link to original page: https://github.com/threefoldtech/jumpscaleX_core/tree/development/docs/Installation#Jumpscale-SDK-Installation

At some point in time this cannot be a copy.
-->


## Getting the basics done
BEfore we start installing we have to get the basics done.  The basics include a small number of required software packages and a GitHub account.  With this done the installation is straightforward.

The generic structure of this manual is:
- [Prerequisites](#prerequisites)
- [Get the jumpscale SDK Installer](#Get-the-jumpscale-SDK-installer)
- [Jumpscale SDK Installation](#Jumpscale-SDK-Installation)
- [More Info](#more-info)

### Supported Operating Systems

- Linux: Ubuntu 18.04
- macOS 10.7 or newer
- Windows 10

The installation method for Linux and macOS are similar with some minor details how to install the prerequisites.  For windows we have a different installation method which you can find [here](jsx_windows.md).  

This manual will start with the software components that are needed to start the install and when needed specific instructions will be linked for different operating systems.  

### Prerequisites

#### Containerisation platform: Docker
At this point in time the local installation of the SDK is installed in a docker container. So we need to have a local installation of the docker desktop or docker-io (depending on your OS).  Installation instructions can be found here [https://docs.docker.com/get-docker/](https://docs.docker.com/get-docker/)

#### Web browser: Chrome browser
For all SDK installations we need to have the chrome browser installed.  Instructions how get get and install it can be found here: [https://www.google.com/chrome/](https://www.google.com/chrome/) 


#### Required software
For the installation and operation to succeed we need to following software installed:
- Python: Python is a programming language that lets you work quickly and integrate systems more effectively. (https://www.python.org/)
- UPX: UPX is a free, portable, extendable, high-performance executable packer for several executable formats. (https://upx.github.io/)
- PatchElf: PatchELF is a simple utility for modifying existing ELF executables and libraries. (https://github.com/NixOS/patchelf)

##### Required software installation on ubuntu 18.04
For Ubuntu all required software is available in ubuntu packages.  The ubuntu package manager is able to install and manage/update packages. If you want to instal from source code please refer to the respective sites listed with the software packages.

Using the package manager:
```bash
apt update -y
apt install -y curl python3 python3-pip upx patchelf
```
This install all the required packages to support the SDK installation

##### Required software installation on macOS
For macOS we recommend using a package manager called Homebrew.  This is a missing component in macOS manages most none-App store software installs.  You can read more about it here: [www.brew.sh](https://brew.sh/)
```bash
# to install brew, skip if already done
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
# install required software
brew update
brew install curl python3 upx patchelf
```
This installx all the required packages to support the SDK installation

In both cases (Linux and macOS) we have Python3 and Python package manager installed. We need to add one Python package to create the installer for the SDK
```bash
pip3 install pyinstaller --user
```

##### Secure access to GitHub: ssh-agent

The SDK is installed from GitHub where the software is maintained by ThreeFold Tech engineers and the community.  You need to have a GitHub account and  uploaded you public ssh-key to have access to the repository.  You can find instructions to get a GitHub account [here](https://help.github.com/en/github/getting-started-with-github/signing-up-for-a-new-github-account) and how to upload your public ssh-key [here](https://help.github.com/en/github/authenticating-to-github/adding-a-new-ssh-key-to-your-github-account)

Please make sure you have an ssh-key pair before doing this.  You can check if you have the key pair created by doing:
```bash
ssh-keygen
```
If the key pair exists you will see something like this:
```bash
Generating public/private rsa key pair.
Enter file in which to save the key (/Users//.ssh/id_rsa): 
/Users//.ssh/id_rsa already exists.
Overwrite (y/n)? n
```
Please answer no as you are all set.  Otherwise the command will generate a key pair for you in the default directory `$HOME/.ssh`.

When this is done you have to make sure that you have a local "agent" running to allow this ssh-key verification to happen.  The ssh-agent loads you private ssh-key enabling it to verify the validity of your public key stored in GitHub.

```bash
eval `ssh-agent`
```
Output will look similar to:
```bash
Agent pid 38489
```
Adding your identity to the agent:
```bash
ssh-add
```
Output will be similar to:
```bash
Identity added: /Users//.ssh/id_rsa (@Weynands-MacBook-Pro.local)
```
To check if your identity is loaded
```bash
ssh-add -L
```
Which yields the following response:
```bash
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCuzUUyKJk0DxlWLikXbez7FWMpGO3XEBbpngzzSF7tMkuV+v3eNpt8zVGK0WYwyL9r0+1TLelHIxhj4HCRnFNfr/S7F+JcUDhe9o/6N8wgPRK4jpIwAhz9V/Sa1tR5SsEqDL3wOOSupuEwZnckbUfAGxvtASGdf5gzOzF0YUt5I7ER2w9QR3FB2e2APPSele6u550BQpspUz7YlQ5gfAx5A5O/HKIlywHlMejyCNzejXRucl3981LsoR1y27iM5D7VetVhahscCr6MBSKUTxmPviuvU6fHAdRzfuxjKmM+ukk/iql9huG2JRNDGBilxzoA0M6j8kceoSY5+udXN/z/ @MacBook-Pro.local
```

Make sure to check whether the presented ssh key is stored in your GitHub account. If not the installation script will break when it's trying to download the latest version from GitHub.

This completes all the prerequisites for the Linux and macOS operating system.  You should be setup to go and install the SDK

##  Jumpscale SDK Installation
With the above done have completed all the prerequisites on the local system. There is one more step to do: select or get a 3botconnect identity.  ThreeFold uses the 3botconnect to identify individuals (and or legal entities). Please find [here](https://github.com/threefoldfoundation/info_tfgridsdk/blob/development/src/3botconnect/3botconnect.md) a description of what it can do.  In order to get one please search the respective app store for your phone (Android and iPhone).

<!--
TODO Look for a better description of the 3botconnect app
-->
The installation requires you to choose a 3botconnect name (any name up to 50 characters) and it has to have a valid email address (unique, every 3bot has to have a unique valid email address).  The 3bot connect app stores a unique 24 word seed key for a digital wallet and that same unique key is also used to identify you for SDK access.

### Get the jumpscale SDK installer
To get the jumpscale SDK installed you have two options:
- get the source code and compile the installer on you local system
- get the binary that works for your operating system

The simplest way to get started is to download the binaries from the [release](https://github.com/threefoldtech/jumpscaleX_core/releases) page for macOS and Linux.  Go to this page, select the latest release or release candidate.

#### Building the jumpscale SDK installer from source code
From the jumpscale SDK release page please download the source code.  Save the source code somewhere where you can unpack and compile the installer.
```bash
tar xzf ./jumpscaleX_core-10.4.tar.gz 
cd jumpscaleX_core-10.4
cd install/
./package.sh
```
This should build you the installer `3sdk` in the dist directory
```bash
cd dist/
ls -al
```
And output will look something like
```bash
total 20128
drwxr-xr-x   3 weynandkuijpers  staff        96 Apr 22 05:54 .
drwxr-xr-x@ 16 weynandkuijpers  staff       512 Apr 22 05:54 ..
-rwxr-xr-x   1 weynandkuijpers  staff  10305394 Apr 22 05:54 3sdk
$ 
```
You can either move this binary to a location in you `$PATH` or leave it here to launch your (local) 3bot

#### Using the jumpscale SDK installer

Now that we have the `3sdk` jumpscale  installer we can launch it
```bash
./3sdk
Welcome to sdk shell, for help, type info, to exit type exit
3sdk>
```
To get more information on the available commands, please type `info()`
```bash
3sdk> info()

show commands available in 3sdk

simulator: manage simulator
    browser: connect browser to your jupyter, make sure its not open yet
    stop: stop simulator & remove the container
    start: install & run a container with SDK & simulator
    shell: get a shell into the simulator
    restart: restart the simulator, this can help to remove all running kernels
container: manage containers
    install: create the 3bot container and install jumpscale inside
    stop: stop specified containers, can use * in name
    start: @param server=True will start 3bot server
    shell: shell into your container
    kosmos: start kosmos shell
    list: list the containers
    threebot: will make sure you have your 3bot alive
    delete: delete specified containers, can use * in name
args: configurable arguments
    identity: you can have multiple identities,
    secret: the secret passphrase as used for encrypting all data
    email
    words: words as used for the encryption key retrieved from 3bot connect app
    reset: reset your arguments for your identity  (secret remains)s
core: core configuration
    branch: branch for the code we use normally development or unstable
    redis: start redis so it will remember our secret and other arguments
install: Install jumpscale on host (not all platforms supported)
```

There are 5 main categories of commands
- **simulator**.  This section provides control commands for the ThreeFold simulator. The simulator models the TFT token economy based on paramters and assumptions.
- **container**. This section provides control for the lcoal container installation of the jumpscale SDK
- args. Environment arguments to facilitate the installation of various components
- core.  Set some core parameters
- install. Install the jumpscale code on the local machine.

Here we will focus on the container installation getting us a local installation of the jumpscale SDK. To install a local jumpscale SDK you need:
- your 3botconnect name chosen in you 3botconnect app installation
- your 3bot registered email address
- your 3bot (24 word) seed key

The install command looks like this:
```bash
3sdk> container threebot identity='<<your 3bot name>>' email='<<your email address>>' words='<<your 24 word seed key>>'
```
The installer will then download a container from the [docker hub](https://hub.docker.com/r/threefoldtech/3bot2) which has most of the needed software installed. It will then pull the latest (stable) releases of the required jumpscale libraries from the GitHub repository (for which you need to have a GitHub account and entered you ssh keys in the security section in your Github account, see [here](#Secure-access-to-GitHub:-ssh-agent))

Once that is done the installer will stop and ask for a secret passphrase
```bash
.......
Receiving objects: 100% (3585/3585), 13.15 MiB | 3.26 MiB/s, done.
Resolving deltas: 100% (510/510), done.
 - install jumpscale for identity: <<your 3bot name>>
specify secret passphrase please::
```

This passphrase is a one-time pass phase which you **do not** have to remember.  It is used to encrypt the seed key in the container.  Enter any random phrase or word (twice).  

After doing this you will see a lot of output scrolling by which is the process of actually implementing the jumpscale libraries in the local container python install.  This will at some point in time be hidden for you as it performs no real function.

After a while you will see this:
```bash
## jumpscale.threebot.me
id:2
 - name                : default
 - tid                 : <<your 3bot ID nr.>
 - tname               : <<<your 3bot name>>
 - email               : <<your email address>>
 - signing_key         : <<your signing key>>
 - verify_key          : <<your verification key>>
 - admins              : ['<<your 3bot name>>']
 - sshkey_name         :
 - sshkey_pub          :
 - sshkey_priv         :

 - save identity:<<your 3bot name>>
Jumpscale X installed successfully
Connection to localhost closed.
 - Install succesfull
OK
++ '[' start == kill ']'
++ tmux -f /sandbox/cfg/.tmux.conf has-session -t main
error connecting to /tmp/tmux-0/default (No such file or directory)
++ '[' 1 -eq 1 ']'
++ echo 'no server running need to start'
++ tmux -f /sandbox/cfg/.tmux.conf new -s main -d 'bash --rcfile /sandbox/bin/env_tmux_detach.sh'
no server running need to start
++ '[' start '!=' start ']'
 - Server started ok
 ```

 This should open up a browser window (crome) with the 3bot connect login screen.