# nodejs install

to build certain modules nodejs is a requirement, we suggest to use a node version manager.

There are a lot of different versions of Node out there. These tools will help you keep track of what version you are using, and also make it easy to install new versions and switch between them. They also make npm easier to set up :)

## OSX

### to install

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
```

### to use

```
nvm install node
nvm use node

```

### to uninstall

```
nvm deactivate
nvm uninstall node
```

## Windows

### to install

TODO: document

### to use

```
nodist use
```

## alternative way: tj/n

see https://github.com/tj/n

```bash
# make cache folder (if missing) and take ownership
sudo mkdir -p /usr/local/n
sudo chown -R $(whoami) /usr/local/n
# take ownership of node install destination folders
sudo chown -R $(whoami) /usr/local/bin /usr/local/lib /usr/local/include /usr/local/share
curl -L https://raw.githubusercontent.com/tj/n/master/bin/n -o n
bash n lts
```