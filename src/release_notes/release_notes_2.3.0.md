# TF Grid 2.3.0 Release Note

## High Level Summary

[__The ThreeFold Grid__](https://wiki.threefold.io/#/grid_why) is a peer-to-peer and autonomous Internet grid that provides game-changing performance and empowers new possibilities. It sets the foundation for a better Internet, based on new principles: peer-to-peer, decentralized, autonomous, private, secure, and sustainable.

__ThreeFold Grid 2.3__ release introduces the addition of testnet resource capacity to make your testing experience more effective. Please go to [Testnet TF Explorer](https://explorer.threefold.io/testnet) for more details.

## What’s New on ThreeFold Grid 2.3.0

### ThreeFold Now

- This 2.3.0 release introduces an improved user interface of [ThreeFold Now Marketplace](https://marketplace.threefold.io/marketplace/#/), providing categories for a better navigation experience. 
- Along with new categories, this release introduces a new ThreeFold Now solution: you can now use a decentralized video calling solution deployable via ThreeFold Now Marketplace on [this link](https://marketplace.threefold.io/marketplace/#/solutions/meetings). 

### [ThreeFold Explorer](https://github.com/threefoldtech/tfexplorer/releases/tag/v0.4.1)

On [ThreeFold Explorer](https://explorer.grid.tf/) you can see node information and check all the available IT Capacity on both Testnet and Mainnet. The encryption scheme used to send sensitive information to workloads is improved. The explorer also only cancels workloads that are actually consuming resources when a capacity pool is exhausted.

### [ThreeFold Connect (rebranded from: 3Bot Connect)](https://github.com/threefoldtech/3Bot_connect/releases/tag/v2.0.0)

- On this release, 3Bot Connect App is rebranded to __ThreeFold Connect App__. The ThreeFold Connect App is your main access point to the ThreeFold Grid.
- A lot of improvement on the sign in process has been made on this release. Now, you can use your FaceID and TouchID to sign into your ThreeFold Connect account. Your 3Bot recovery flow is now improved and sign in issues for incorrect setup time on their mobile device is fixed. 
- Performance and feature-wise, the app’s speed is increased and FreeFlow Pages feature is removed from ThreeFold Connect app since it is no longer promoted for usage.

### 3Bot Deployer

3Bot Deployer is there to deploy your virtual system administrator in a fast and easy manner. Deployment speed is increased and the deployment flow of 3Bot is simplified. The decentralization aspect of your 3Bot is also improved by making it possible for you to choose where you want your 3Bot to be hosted - be it on a specific location, farm, or even to a specific node that you prefer.

### 3Bot

With this 2.3.0 release, a lot of automation to the processes has been added to scale the effectiveness of 3Bot deployment and improve your user experience as described below:

- When you have successfully deployed a hosted 3Bot, a functional wallet will be added automatically. 
- Automation is also added to the way how packages are added to your 3Bot. You are now able to directly add packages from subfolders in your Github repos and the package code can be reloaded without the need to restart the 3Bot. 
- You can now automatically extend your capacity pools when they are expiring; that way it will minimize workload downtime due to lacking resources. An escalation email will also be sent automatically as a reminder to extend your capacity pool.
- SSH access capability is added, as well as a backup option for downloaded packages, .ssh, and code directories that improve your workload management and security.

### [Zero OS](https://github.com/threefoldtech/zos/releases/tag/v0.4.6)

Zero OS (ZOS) is the operating system which allows the 3Nodes to be used to provide IT capacity required by the solutions running on the TF Grid. With this Grid 2.3.0 release, the resource management on Zero OS level is improved. The main focus is on improving the accuracy of the information reported by the nodes to the explorer regarding the amount of reserved capacity and improving the freeing up of unused resources.

### Jumpscale Framework ([JS-NG](https://github.com/threefoldtech/js-ng/releases/tag/v11.0-b7) and [JS-SDK](https://github.com/threefoldtech/js-sdk/releases/tag/11.0-b11))

Jumpscale is an automation framework and the foundation of the autonomous layer. It includes all the components involved in creating the IT architecture for autonomous operations, like a container running a webserver, a database server, and then all the required network paths in between. This release introduces a lot of component improvements and bugs fixes, such as adding statistics to containers and making it easier for monitoring, as well as improved the logs of containers. We have also added support for test certificates.