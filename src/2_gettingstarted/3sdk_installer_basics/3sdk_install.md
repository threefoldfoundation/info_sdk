# Install 3sdk

* [Requirements](#Requirements)
* [3Bot private key (3Bot words)](#Get-your-3Bot-words)
* [Install 3sdk command line](#Get-3sdk-binaries)
* [Use 3sdk command line from source](#Using-3sdk-from-source-experts-only)
* [Installation on windows](3sdk_windows.md)

## Requirements

- [Docker](https://docs.docker.com/desktop/#download-and-install)
- [Chrome browser](https://www.google.com/chrome/) for OSX users
- [Git](https://git-scm.com/downloads) (Only in expert mode)

## Get 3sdk binaries

Binaries can be downloaded from the [Github release page](https://github.com/threefoldtech/jumpscaleX_core/releases) for MacOSX, Linux and Windows.

After downloading the 3sdk make them executable:

- On Linux, in a terminal do `chmod +x 3sdk`.
- On OSX you probably will have to go to security settings & allow the os to start the 3sdk application.
- On Windows make sure the [requirements](3sdk_windows) are met.

Now go to [3sdk_use](3sdk_use.md) to use the 3sdk to get yourself a 3sdk container on your system using docker.

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
