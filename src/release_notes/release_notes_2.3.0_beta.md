# TF Grid 2.3.0 Beta Release Note

## High Level Summary

[The ThreeFold Grid](https://wiki.threefold.io/#/grid_why) is a peer-to-peer and autonomous Internet grid that provides game-changing performance and empowers new possibilities. It sets the foundation for a better Internet, based on new principles: Peer-to-Peer, decentralized, autonomous, private, secure, and sustainable.

ThreeFold Grid 2.3 Beta release introduces the addition of testnet resource capacity to make your testing experience more effective. Please go to 
[Testnet TF Explorer](https://explorer.testnet.grid.tf/) for more details. We have also added some improvements to the grid’s stability, new features, as well as introducing TFT and Testnet TFT as the only tokens used for reserving capacity on the Grid to avoid payment complications.


## What’s New on ThreeFold Grid 2.3.0

### ThreeFold NOW

- With this 2.3 Beta release, we are introducing an improved user interface of [ThreeFold NOW Marketplace](marketplace.threefold.io), providing categories for a better navigation experience. 
- Along with new categories, we are also introducing one new ThreeFold NOW solution: you can now try using a decentralized video calling solution deployable via ThreeFold NOW Marketplace on [this link](https://marketplace.threefold.io/marketplace/#/solutions/meetings). 


### [ThreeFold Explorer](https://github.com/threefoldtech/tfexplorer/releases/tag/v0.4.1)

 ThreeFold Explorer is the marketplace for the IT capacity where you could explore and purchase all the available nodes on both testnet and mainnet environment by using the smart contract for IT concept. You can also reserve the nodes you see on the explorer  by using the capacity pool feature in your hosted 3Bot. On this release, we have improved the security by adding an authentication process for the creation of node purchase request. From today on we will also only be allowing workload deletion if it is out of resource.


### [3Bot Connect](https://github.com/threefoldtech/3Bot_connect/releases/tag/v2.0.0)

- A lot of improvement on the signing in process have been made on this release. From today on, you could use your FaceID and TouchID to sign into your 3Bot Connect account. We have also improved your 3Bot recovery flow and fixed signin issues for people with an incorrect time on their mobile device. 
- Performance and feature wise, we have increased the app’s speed and removed Freeflow Pages feature from 3Bot Connect app since it is no longer promoted for usage.


### 3Bot Deployer

A 3Bot deployer should do what it was designed to do: deploy your virtual system administrator in a fast and easy manner. On this release, we have increased the deployment speed as well as improved the deployment flow of 3Bot. We have also improved the decentralization aspect of your 3Bot by making it possible for you to choose where you would assign your 3Bot- be it on a specific location, farm, or even to a specific node that you prefer.


### 3Bot

With this 2.3 Beta release, we are adding a lot of automation to the processes to scale the effectiveness of 3Bot deployment and improve your user experience as described below: 

- when you have successfully deployed a hosted 3Bot, a functional wallet would be added automatically. 
- Automation is also added with the way how packages are added to your 3Bot. You are now able to directly add packages from subfolders in your github repos and the package sources will automatically reload itself. 
- You can now automatically extend your capacity pools when they are expiring, that way it will minimize workload downtime due to lacking resources. An escalation email would also be sent automatically as a reminder to extend your capacity pool.
- we have also added SSH access capability, as well as a backup option for downloaded packages, .ssh, and code directories that improve your workload management and security.



### [Zero-OS V0.4.5](https://github.com/threefoldtech/zos/releases/tag/v0.4.5-rc2)

Zero-OS (ZOS) is the operating system which allows the 3Nodes to be used to provide IT capacity required by the solutions running on the TFGrid. With this Grid 2.3 release, we have improved the resource management on Zero-OS level. The main focus is on improving the accuracy of the information reported by the nodes to the explorer regarding the amount of reserved capacity and improving the freeing of unused resources.


### Jumpscale Framework ([JS-NG](https://github.com/threefoldtech/js-ng/releases/tag/v11.0-b7) and [JS-SDK](https://github.com/threefoldtech/js-sdk/releases/tag/11.0-b11)) v11.0-b7]

Jumpscale is an automation framework and the foundation of the autonomous layer. It includes all the components involved in creating the IT architecture for autonomous operations, like a container running a webserver, a database server, and then all the required network paths in between. On this release we have created some component improvements and bugs fixes, such as adding statistics to container and making it easier for monitorin, as well as improved the logs of containers. We have also added support for test certificates.


