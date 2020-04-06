# info_tfgridsdk

manual for the ThreeFold Grid

## how to contributed

### how to install mdbook

OSX:

```bash
brew install mdbook
```

### get the documents (content)

```bash
mkdir -p ~/code/github/threefoldfoundation
cd ~/code/github/threefoldfoundation
clone https://github.com/threefoldfoundation/info_tfgridsdk/ -b development
```

### use mdbook locally

```bash
cd ~/code/github/threefoldfoundation/info_tfgridsdk
#will open local browser
./serve.sh
```

### Editing the wikis

- all md files are under src/docs directory, please make sure you get all your changes there.
- to make link in md file to open in new tab use this 
- if you are planning ot make massive adjustments, please create your own branch and  clone / pull that branch.  When done please create a well described pull request and push it forwards for integration.

Branches and there purpose

**Master** This branch containes the information which is currently considered as production content.

**Development** This branch is used to be the staging branch before things are pulled into master.  Normally we try to have at the end of the day all the branches that are used for personal development and work to be pulled into the development branch.  Development is pushed into master every few days.

**Other branches**  Everyone that wants to participate in this projects, please create your own branch from development (clone the developement branch from the repository and create your own branch).  Please consider dooing a pull request at the end of every day in order for the branches not to divert too much.


### Owners

This repository is maintained by:

@weynandkuijpers

### Meetings
The team holds a update meeting twice a month, on monday at 17:00

<!-- TODO: create and enter a zoon link for the meeting -->
Zoom URL: 

### tips and trics

```
<a href="http://example.com/" target="_blank">Hello, world!</a>
```

