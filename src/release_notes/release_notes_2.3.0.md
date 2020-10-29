# TF Grid 2.3.0 Release Note 

## High Level Brief Summary

This release introduces an improvement in stability, secret container logs, workload messages security, as well as introducing TFT as the only token used for reserving capacity on the Grid. We minimized the options into TFT to avoid complication. TFTA can be converted to TFT easily. With this release we also introduced demo solution integration with ThreeFold NOW Experiences. Each release will reveal new additions of TF NOW solutions, wih a new improved user interface providing category for each solutions.


## Highlights

Some other new features also introduces in this version:


### TF NOW Marketplace

- [Fresh looking UI for the marketplace](https://github.com/threefoldtech/js-sdk/issues/1400)
- Various improvements in images used for ease of deployment 
- [Automation tests for (gitea, taiga, discourse, wiki, blog, website, mattermost, cryptpad, peertube)](https://github.com/threefoldtech/js-sdk/issues/1226 https://github.com/threefoldtech/js-sdk/issues/1265)
- [Video Chat solution is now available for deployment](https://github.com/threefoldtech/js-sdk/pull/1379)


### 3Bot

- When created, it is initialized with  a functional mainnet/testnet wallet
- Possibility to add packages from subfolders in github repos and live reloading of package sources
- Dashboard UI improvements, which includes a jumpscale configuration UI
- [Added Escalation emails]( https://github.com/threefoldtech/js-sdk/issues/1413)
- [Possibility to auto-extend pools that are about to expire](https://github.com/threefoldtech/js-sdk/issues/1337)
- Added backup for downloaded packages, .ssh and code directories
- Added SSH access
- [Added zinit flist](https://github.com/threefoldtech/js-sdk/issues/856)


### [3Bot Deployer](https://github.com/threefoldtech/home/issues/906)

- Deployment speed-up
- Improved deployment flow
- Possibility to choose the 3bot deployment location (auto, by farm, by node)
- [3Bot website overview](https://github.com/threefoldtech/js-sdk/issues/1412)
- Plan option
- [3Bot deployment location (auto, by farm, by node)](https://github.com/threefoldtech/js-sdk/issues/1415)
- [Sort by capacity](https://github.com/threefoldtech/js-sdk/issues/1409)

### [Zero-OS V0.4.5](https://github.com/threefoldtech/zos/releases/tag/v0.4.5-rc2)

- Better resource management:
The main focus is on improving the accuracy of the information reported by the nodes to the explorer regarding the amount of reserved capacity and improving the freeing of unused resources


### [JS-NG v11.0-b7](github.com/threefoldtech/js-ng/releases/tag/v11.0-b7)

- [Supporting execution of multiple commands in using jsng command](https://github.com/threefoldtech/js-ng/issues/476)
- [Gedis live reloading](https://github.com/threefoldtech/js-ng/pull/484)


### [JS-SDK v11.0-b11](https://github.com/threefoldtech/js-sdk/releases/tag/untagged-14056cea521a03496a1f)

- [Added notification system](https://github.com/threefoldtech/js-sdk/issues/1335)
- [Support different acmeservers other than letsencrypt](https://github.com/threefoldtech/js-sdk/pull/1362)
- [Added packages from subpaths in github repos](https://github.com/threefoldtech/js-sdk/issues/1120)
- [Added Jumpscale configuration UI](https://github.com/threefoldtech/js-sdk/issues/743)
- [ZOS security upgrade to node encryption](https://github.com/threefoldtech/js-sdk/pull/1430)
- [Start 3bot with mainnet, testnet wallets ready for the user](https://github.com/threefoldtech/js-sdk/issues/1414)
- [Parameterized zos sal to allow execution with different identities](https://github.com/threefoldtech/js-sdk/issues/1334)
- [Added explorer logs option for tracing explorer requests](https://github.com/threefoldtech/js-sdk/issues/1116)
- Block failing nodes to deploy 
- Added improvements in taiga client for circles management 
- [Added statsaggregator and containers monitor tool](https://github.com/threefoldtech/js-sdk/pull/1349)
- [Added secret logs for containers(https://github.com/threefoldtech/js-sdk/pull/1260)
- TFT only usage  
- [Added automation tests for (network, ubuntu, k8s, minio, pools, generic flist, solution expose](https://github.com/threefoldtech/js-sdk/issues/1226 https://github.com/threefoldtech/js-sdk/issues/1265)
- [Support for test certificates when deploying](https://github.com/threefoldtech/js-sdk/issues/608)
- Darkmode UI improvements 
- [Containers logs for nginx, trc, 3bot deployments](https://github.com/threefoldtech/js-sdk/issues/1452 https://github.com/threefoldtech/js-sdk/pull/1261 https://github.com/threefoldtech/js-sdk/pull/1252)

### [TF Explorer V0.4.1](github.com/threefoldtech/tfexplorer/releases/tag/v0.4.1)

- Not allowing user to update its public key
- Added solid error type so client can check


### [3Bot Connect V2.0](https://github.com/threefoldtech/3Bot_connect/releases/tag/v2.0.0)

- Removal of freeflowpages
- Improved support for TouchID/FaceID
- Increased performance and speed
- Improved recovery flow
- Fixed login issues for people with an incorrect time on their mobile device
