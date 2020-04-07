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
mdbook serve -n 0.0.0.0 -o
```

### Editing the wikis

- all md files are under src/docs directory, please make sure you get all your changes there.
- to make link in md file to open in new tab use this 

#### tips and trics

```
<a href="http://example.com/" target="_blank">Hello, world!</a>
```

