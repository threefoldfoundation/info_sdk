# ThreeFold Grid Manual

### For progress please follow web presence board on Circles tool: https://circles.threefold.me/project/despiegk-product_web_threefold/wiki/home

## Manual Content

Welcome to __Grid Manual__.
Before contributing to this repo, one should understand that this repo reflects on three different manuals for 2 different versions of the TF Grid, and the content is clustered within 2 different branches.

1. [TF Grid 2.4 manual](https://manual.threefold.io) - the manual for the grid on 2.4.

### Creating Issues
When creating a new issue, please identify if it's an issue from TF Grid Manual 2.1 or TF Grid Manual 2.2.
Title example:
MANUAL 2.4 - Create a tutorial on installing wireguard
MANUAL 2.3 - Add placeholder for intro.md

### Run the wiki yourself

PS: we have a new tool how to serve the wiki, its easier to use and has more support for the future (based on an own implemented server & docsify)

#### Get the documents (content)

The documentation is online but could also be downloaded for reading purposes and or updating/editing. 

```bash
mkdir -p ~/code/github/Threefoldfoundation
cd ~/code/github/Threefoldfoundation
clone https://github.com/Threefoldfoundation/info_TF Gridsdk/ -b development
#if you are on OSX do:
sh install_osx.sh
```

#### If you are on linux

- build the tool in https://github.com/threebotserver/publishingtools
- make sure tf_wiki is in path


#### Run the server

```bash
cd ~/code/github/Threefoldfoundation/info_TF Gridsdk
run.sh
```

now go to: http://localhost:3000/index.html#/intro

### How to contribute

Contribution is welcome. The TF Grid and the technology is an open source project and we welcome external help to make this project even better. This manual is all about how to get started with the Software Development Kit,from downloading it and installing the SDK to executing workloads.

The steps needed to get the documentation on your device are:
- install the tool & get the content, see above
- if you want to edit, create your own branch to edit

Learn how to use the tool well:

- see https://github.com/Threefoldfoundation/info_TF Gridsdk/blob/development/src/tips_tricks/tfweb.md


#### Helping us to improve and edit the wikis

- all md files are under src/docs directory, please make sure you get all your changes there.
- to make link in md file to open in new tab use this 
- if you are planning ot make massive adjustments, please create your own branch and clone / pull that branch. When done please create a well described pull request and push it forwards for integration.

#### Branches and there purpose

**Master** This branch containes the information which is currently considered as production content.

**Development** This branch is used to be the staging branch before things are pulled into master. Normally we try to have at the end of the day all the branches that are used for personal development and work to be pulled into the development branch. Development is pushed into master every few days.

**Other branches** Everyone that wants to participate in this projects, please create your own branch from development (clone the developement branch from the repository and create your own branch). Please consider dooing a pull request at the end of every day in order for the branches not to divert too much.


### Owners

This repository is maintained by:
@sasha-astiadi


### Meetings
The team holds a update meeting twice a month, on monday at 17:00

<!-- TODO: create and enter a zoon link for the meeting -->
Zoom URL: 

### tips and tricks

```
<a href="http://example.com/" target="_blank">Hello, world!</a>
```

