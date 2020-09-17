# Provisioning Code

## Prerequisites
In order to be able to deploy anything on the grid, you will have to have the following components beforehand
- Install 3Bot Connect App to get an identity. More details could be found in [3Bot connect installation](3botconnect_install.md) and [3Bot connect setup](3botconnect_overview.md)
- Installation of js-sdk. Getting started instructions to install the sdk could be found [here](3sdk_install.md)
 Identity could be verified by checking `j.core.identity.me`
- Install wireguard software. Instructions to how to get his installed on your platform could be found [here](https://www.wireguard.com/install/)
- capacity reservation are not free so you will need to have some ThreeFold Tokens (TFT) to play around with. Instructions to get tokens to your stellar wallet could be found [here](tokens.md

Once the previously mentioned requirements are met, you are ready to deploy on the grid. This is mainly done using the `zos` client. Some examples are further explained below


## Code Examples

This section contains some example code showing how you could generate workloads reservation using the python SDK.

Examples:

- [Reserve some IT capacity by creating a capacity pool](code_pool.md)
- [Deploy a network](code_network.md)
- [Deploy a container](code_container.md)
- [Deploy a kubernetes cluster](code_kubernetes.md)
- [Deploy a Minio server for archive storage](code_storage.md)
- [DNS management](code_web.md)
