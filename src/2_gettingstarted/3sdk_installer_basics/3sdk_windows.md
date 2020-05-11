# Installing 3sdk for windows

## Requirements

- Windows 10 64bit Pro, Enterprise or Education (Build 15063 or later).
  - Hyper-V and Containers Windows features must be enabled.
  - The following hardware prerequisites are required to -   successfully run Client Hyper-V on Windows 10:
    - 64 bit processor with Second Level Address Translation (SLAT)
    - 4GB system RAM
    - BIOS-level hardware virtualization support must be enabled - in the BIOS settings

- Docker, Install guide [here](https://docs.docker.com/docker-for-windows/)
- Git, Install guide [here](https://git-scm.com/download/win), 64-bit version (only for expert mode)

## Configuring Docker

- We need to configure docker to use linux containers during installation and we need to enable file sharing “C” in Docker desktop, It can ask you about in the first time automatically you can allow it directly

![windows_docker_ask](docker_windows1.png)

- Volume mounting requires shared drives for Linux containers (not for Windows containers). Click whale menu and then Settings > Shared Drives and share the drive "c", showed as below

![windows_docker](docker_windows.png)

## Installation

- Make sure docker daemon is running, you can find its icon next to the clock in taskbar

- Download the latest binary release from this page [jumpscaleX releases](https://github.com/threefoldtech/jumpscaleX_core/releases)

- Check [3sdk_install](3sdk_install.md) to know how to get your 3bot connect words in installation section

- Go to the the command prompt then run the exe or just double click it.

![windows](install_windows.png)

## Advanced

If you want to use the `3sdk` in `--expert` mode you need to have the following configured aswell

### Configuring GIT

Git for windows should be configured to be using `LF` line endings instead of windows `CLRF`

Using the following.

```bash
git config --global core.autocrlf false
git config --global core.eol lf
```

[source for changing in windows](https://stackoverflow.com/questions/2517190/how-do-i-force-git-to-use-lf-instead-of-crlf-under-windows)

### Configuring SSH and SSH-AGENT

- You may have `ssh-agent` not working on windows you can start it from the windows task manager, head to `services` right click then `start`
as showed in the following
    ![sshagent](sshagent.png)

- Then generating a ssh-key as showed below.

```
ssh-keygen -t ecdsa -b 521
```

and don't add a passcode, just enter, then

```
ssh-add
```

To make sure the key is loaded you can see it via

```
ssh-add -L
```

![sshkeys](sshkeys.png)

