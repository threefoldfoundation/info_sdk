# Get yourself a Threebot

You can either create a Threebot on your local machine or hosted on the TF Grid. 

## Create a hosted Threebot

!!!include:threebot.md

## Create a Threebot on your local machine

A Threebot on your local machine requires the installation of an SDK. Please find the instructions below. 

### Quick Start with js-sdk

#### System requirements for installation on the host

- Ubuntu 18.04 or higher, MacOS 10.9 or higher
- Windows 10, version 2004 can run using [wsl2](https://docs.microsoft.com/en-us/windows/wsl/wsl2-index) using ubuntu 20.04 or later
- The SDK uses  [python3](python.org), python3-pip, [git](https://git-scm.com), poetry, [nginx](https://www.nginx.com), [redis](https://redis.io), [mkcert](https://github.com/FiloSottile/mkcert) is needed to trust the self signed certificates when used in local development environment.
- Browser (we recommend using Google chrome)

##### Mac OSX
For Mac OSX 

Install packages (git, nginx, redis-server, tmux, python3) on MacOS
  ```
  brew install nginx redis tmux git python3
  ```


##### Ubuntu

For GNU/Linux Ubuntu systems
  ```
  apt-get update
  apt-get install -y git python3-venv python3-pip redis-server tmux nginx;
  pip3 install poetry
  ```
  
#### Installing the js-sdk

After having the [requirements](https://github.com/threefoldtech/js-sdk/blob/development/docs/wiki/quick_start.md#system-requirements-for-installation-on-the-host) installed on your system 

##### Installation using pip (don't use yet until we have an official release)

Just doing `python3 -m pip install js-sdk` is enough

##### Installation for experts or developers

- Make sure to have the [requirements](https://github.com/threefoldtech/js-sdk/blob/development/docs/wiki/quick_start.md#system-requirements-for-installation-on-the-host) installed 
This version of the SDK tries to be isolated as possible in case of developers or the endusers, and we are achieving that level of isolation using poetry for the whole development/publishing process

- To install poetry `pip3 install poetry` or from [here](https://python-poetry.org/docs/#installation)
- Clone the repository `git clone https://github.com/threefoldtech/js-sdk`
- Prepare the environment and the python dependencies

  ```bash
  cd js-sdk
  poetry update
  poetry install
  poetry shell
  ```

#### Running your 3bot

##### using mkcert
[mkcert](https://github.com/FiloSottile/mkcert) is optionally needed to trust the self signed certificates when used in local development environment. All you need to do is install it in your system under the name `mkcert` and do `mkcert -install`

After the installation steps you should have an executable `threebot`

- in case of pip it should be available for the user
- in case of poetry you need to be in the isolated environment using `poetry shell`

threebot server can run using `threebot start --local` starts a server on `8443, 8080`. If you want to use `80, 443` ports you need to set [capabilities](runninng3bot.md) for nginx binary (in case of linux) or install as root in case of OSX

  ```bash
  threebot start --local
  ```

- This will take you to configure your identity, It will ask you about your the network you want to use, 3bot name, email, and words.

- Then it will start threebot server you will see some thing like that

  ![configure](images/identity_new.png)

- After success you can visit the admin dashboard at https://localhost:8443/admin and start creating reservations

  ![configure](images/success.png)
