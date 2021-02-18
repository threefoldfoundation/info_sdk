# Release notes TF Grid 2.2.0

This release introduces a major change in the way capacity is reserved on the Grid. In previous version, the deployment of workloads and the payment of capacity was done in a single step. This lead to different types of issues and a bad user experience.

As as result of this observation, a new concept has been introduced: The capacity pool. The idea behind is to decouple the reservation/payment of capacity from the provisioning of workloads. Having these 2 steps split apart enable nice new features:

* Instantaneous provisioning of workloads. Since there is no more need to wait for blockchain transaction worklaods can be deployed in seconds
* No more expiration of workloads. As long as user keeps its capacity pool filled, all attached workloads will continue to live forever
* Ability to cancel a workload without "losing" tokens used to deploy it.
* Easier capacity planning and organization of the capacity reserved

For a complete detail and rational about this new feature, head to the [specification document](https://github.com/threefoldtech/tfexplorer/blob/master/specs/modify_IT_contract_over_time.md).

## Higlights

Some other new features also introduces in this version:

### Zero-OS

* Hard drive disk are now automatically shutdown when not used. This feature should greatly improve the power consumption of servers with a lot of disks but few actual usage.
* A new networking option is available for your container. You can now ask a container to have an extra interface that is connected to  the [Yggdrasil network](https://yggdrasil-network.github.io). This allow you to seamlessly expose service on Yggdrasil

### Jumpscale

* all new js-ng, light-weight with built in schema parser, pluggable and highly modular.
* much improved Admin Panel and all new threefold_now

### Component versions

* Jumpscale/SDK: `js-ng 11.0.0-alpha3`
  + [Github project](https://github.com/orgs/Threefoldtech/projects/104)
  + [Release notes](https://github.com/threefoldtech/js-sdk/releases/tag/v11.0.0-a3)

* Zero-OS v2: `0.4.0`
  + [Github project](https://github.com/orgs/threefoldtech/projects/72)
  + [Release notes](https://github.com/threefoldtech/zos/releases/tag/v0.4.0)

* TFExplorer: `0.4.0`
  + [Release notes](https://github.com/Threefoldtech/tfexplorer/releases/tag/v0.4.0)
