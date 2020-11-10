# TF Grid 2.3.0 Beta Release Note

## High Level Brief Summary

This beta release introduces addition of testnet resource capacity- please go to [Testnet TF Explorer](https://explorer.testnet.grid.tf) for more details on the added resources. We have also added some improvements on stability, including but not limited to: adding secret container logs, workload messages security, as well as introducing TFT and Testnet TFT as the only tokens used for reserving capacity on the Grid. We minimized the options into TFT to avoid payment complication.

With this release we also introduced demo solution integration with ThreeFold NOW Experiences. Each release will reveal new additions of TF NOW solutions, with a new improved user interface providing solution categories for a better navigation experience.

## Highlights

Some other new features also introduced in this version:

### TF NOW Marketplace

- UI improvement: new solution categorization for better navigational experience.
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

- Increase in Deployment speed
- Improved deployment flow
- Possibility to choose the 3Bot deployment location (auto, by farm, by node)

### [Zero-OS V0.4.5](https://github.com/threefoldtech/zos/releases/tag/v0.4.5-rc2)

- Better resource management:
The main focus is on improving the accuracy of the information reported by the nodes to the explorer regarding the amount of reserved capacity and improving the freeing of unused resources

### [JS-NG v11.0-b7](https://github.com/threefoldtech/js-ng/releases/tag/v11.0-b7)

- Technical improvement: Fix string representation of base classes.

### [JS-SDK v11.0-b11](https://github.com/threefoldtech/js-sdk/releases/tag/11.0-b11)

- Container statistics and easier monitoring
- Improved container logs
- Support for test certificates

### [TF Explorer V0.4.1](https://github.com/threefoldtech/tfexplorer/releases/tag/v0.4.1)

 - Security improvement: added an authentication process for request creation
 - Only allowing workload deletion if it is out of resource.

### [3Bot Connect V2.0](https://github.com/threefoldtech/3Bot_connect/releases/tag/v2.0.0)

- Removal of freeflowpages
- Improved support for TouchID/FaceID
- Increased performance and speed
- Improved recovery flow
- Fixed login issues for people with an incorrect time on their mobile device
