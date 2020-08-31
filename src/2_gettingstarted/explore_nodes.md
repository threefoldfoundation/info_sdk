# How to select a node in the grid

One of the first things to do when you are preparing to deploy some workloads on the Grid is to select the nodes you are going to use.
Depending on what your workloads and requirements are, there are different aspects to take in account.

The Grid explorers gather all the statistics of the nodes and is your source of information to select them.

Explorer address for each network:

- Mainnet: [https://explorer.grid.tf/](https://explorer.grid.tf/) 
 - Main production network, this is usually what you want to use.
- Testnet: [https://explorer.testnet.grid.tf/](https://explorer.testnet.grid.tf/)
 - Test network where new feature of 0-OS are tested. No stability warranty.

You could also access the explorer from the Admin panel by clicking on the `Capacity` tab in the left menu. ![./img/capacity_menu.png](./img/capacity_menu.png)

## Information reported by the nodes to the Explorer

### Node uptime

For how long the node has been running. This could give you an idea how how stable this node is.

### Total capacity

The total amount of resource units this node has to offer. Combine this with the reserved capacity value and you could know how much capacity is left available.

`Available Capacity = Total Capacity - Reserved capacity`

At the moment only CRU and MRU could be over provisioned on the node. HRU and SRU are strict and could not be over provisioned.

### Reserved capacity

The amount of resource already reserved on the node.

### Number of workloads deployed

The amount of each workloads currently deployed on the node.

### Geographic Location

Where the node is located in the world. This information is gather using the IP address of the node. It could happens that this information is not extremely accurate and depends on the GeoIP database.

### Farm

To which farm this node belongs to.

### Free to use

Specify if this node capacity could be reserved with `FreeTFT` or not.

If the node is marked as free to use. Only `FreeTFT` could be used to pay the reserved capacity.

The currency used to reserve capacity is important to take into account. Because a reservation must be paid in a single transaction, all the nodes used in a reservation must all be free to use or not. Mixing both is not possible.

### Last heartbeat

The date and time at which the explorer received an heartbeat from the node. We consider a node offline is the explorer did not receive a heartbeat for more than 10 minutes.

Make sure to always skip offline node when doing a reservation. Failing to do so will leave your reservation blocked until its provision timeout is reached and then couldcelled.

### List of network interfaces

This gives you the network configuration of the node. This is important when you create your networks
