# k8bernetes cluster

This primitives allow a user to deploy a kubernetes cluster.

A cluster must be composed of at least 2 nodes. One master node and any number of worker nodes.
TODO: copy from https://github.com/threefoldtech/zos/blob/master/docs/kubernetes/README.md

## Reservation definition

Here is the schema used to define a 0-DB namespace reservation:

- **NodeId**:
- **Size**: Kubernetes VMs come in 2 sizes. see [VM Sizes](#vm-sizes)
- **NetworkId**: The name of the network created using a [network](./network.md) primitive.
- **Ipaddress**: The IP address to give to the VM
- **ClusterSecret**: The value of this field must be the same for all the member of a cluster
- **MasterIps**: If this VM is not the master of the cluster, add the IP address of the master node here
- **SshKeys**: A list of SSH public key to authorize into the VM. Don't forget to add yours here or you won't be able to reach the node at all.

### VM Sizes

| size | vCpu | RAM (GiB) | Storage (GiB) |
| --- | --- | --- | --- |
| 2 | 1 | 2 | 50 |
| 1 | 2 | 4 | 100 |

## Example

```python
zos = j.sal.zosv2

# create a reservation
r = zos.reservation_create()

# define the kubernetes cluster
master_node = '2fi9ZZiBGW4G9pnrN656bMfW6x55RSoHDeMrd9pgSA8T'
worker_node = '72CP8QPhMSpF7MbSvNR1TYZFbTnbRiuyvq5xwcoRNAib'
cluster_secret = 'supersecret'
size = 1
network_name = 'demo_network'
sshkeys = ['ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMtml/KgilrDqSeFDBRLImhoAfIqikR2N9XH3pVbb7ex']

master = zos.kubernetes.add_master(
    reservation=r,
    node_id=master_node,
    network_name=network_name,
    cluster_secret=cluster_secret,
    ip_address='172.24.1.20',
    size=size,
    ssh_keys=sshkeys)


worker = zos.kubernetes.add_worker(
    reservation=r,
    node_id=worker_node,
    network_name=network_name,
    cluster_secret=cluster_secret,
    ip_address='172.24.2.20',
    size=size,
    master_ip=master.ipaddress,
    ssh_keys=sshkeys)



expiration = j.data.time.epoch + (3600 * 24 * 365) # a year
# register the reservation
registered_reservation = zos.reservation_register(r, expiration)

time.sleep(120)
# inspect the result of the reservation provisioning
result = zos.reservation_result(registered_reservation.reservation_id)

print("provisioning result")
print(result)
```
