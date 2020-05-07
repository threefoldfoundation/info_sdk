# Install 3sdk

* [Requirements](#Requirements)
* [3bot private key (3bot words)](#Get-your-3bot-words)
* [Install 3sdk command line](#Get-3sdk-binaries)
* [Use 3sdk command line from source](#Using-3sdk-from-source-experts-only)
* [Installation on windows](3sdk_windows.md)

## Requirements

- Docker
- Chrome browser for OSX users
- Git

## Get 3sdk binaries

Binaries should be in the [release](https://github.com/threefoldtech/jumpscaleX_core/releases) page for osx and linux

After downloading the 3sdk make them executable `chmod +x 3sdk`.

In terminal do

```shell
3sdk
```

- On OSX you probably will have to go to security settings & allow the os to start the 3sdk application.
- Now go to [3sdk_use](3sdk_use.md) to use the 3sdk to get yourself a 3sdk container on your system using docker.

## Using 3sdk from source (experts only)

This will require python3, pip3 and git on the user system

```shell
mkdir -p ~/sandbox/code/github/threefoldtech/
cd ~/sandbox/code/github/threefoldtech/
git clone -b development https://github.com/threefoldtech/jumpscaleX_core/
cd jumpscaleX_core/install
# on Linux
pip3 install --user -e .
# On Mac
pip3 install -e .
```

Check [Troubleshooting](3sdk_troubleshooting.md) for help.
