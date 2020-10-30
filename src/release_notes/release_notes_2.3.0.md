# TF Grid 2.3.0 Release Note

## High Level Brief Summary

This release introduces an improvement in stability, secret container logs, workload messages security, as well as introducing TFT as the only token used for reserving capacity on the Gridt. TFTA can be converted to TFT easily.

With this release we also introduced demo solution integration with ThreeFold NOW Experiences. Each release will reveal new additions of TF NOW solutions, with a new improved user interface providing category for each solutions.

## Highlights

Some other new features also introduces in this version:

### TF NOW Marketplace

- UI improvements
- Video Chat solution is now available for deployment

### 3Bot

- When created, it is initialized with  a functional wallet
- Possibility to add packages from subfolders in github repos and live reloading of package sources
- Dashboard UI improvements, which includes a jumpscale configuration UI
- Added Escalation emails
- Possibility to auto-extend pools that are about to expire
- Added backup for downloaded packages, .ssh and code directories
- Added SSH access

### 3Bot Deployer

- deployment speed-up
- Improved deployment flow
- Possibility to choose the 3bot deployment location (auto, by farm, by node)

### [Zero-OS V0.4.5](https://github.com/threefoldtech/zos/releases/tag/v0.4.5-rc2)

- Better resource management:
The main focus is on improving the accuracy of the information reported by the nodes to the explorer regarding the amount of reserved capacity and improving the freeing of unused resources

### [JS-NG v11.0-b7](github.com/threefoldtech/js-ng/releases/tag/v11.0-b7)

### [JS-SDK v11.0-b11](https://github.com/threefoldtech/js-sdk/releases/tag/untagged-14056cea521a03496a1f)

- Container statistics and easier monitoring
- Improved container logs
- Support for test certificates

### [TF Explorer V0.4.1](github.com/threefoldtech/tfexplorer/releases/tag/v0.4.1)

### [3Bot Connect V2.0](https://github.com/threefoldtech/3Bot_connect/releases/tag/v2.0.0)

- Removal of freeflowpages
- Improved support for TouchID/FaceID
- Increased performance and speed
- Improved recovery flow
- Fixed login issues for people with an incorrect time on their mobile device
