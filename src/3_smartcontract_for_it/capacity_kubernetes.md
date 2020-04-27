# K8bernetes cluster

![](./img/kubernetes_intro.png)

This primitive allows a user to deploy a kubernetes cluster.

A cluster must be composed of at least 2 nodes. One master node and any number of worker nodes.

A kubernetes cluster can be linked to our other primitives.

## Reservation definition

Schema used to define a 0-DB namespace reservation:

- **NodeId**:
- **Size**: Kubernetes VMs come in 2 sizes. see [VM Sizes](#vm-sizes)
- **NetworkId**: The name of the network created using a [network](network.md) primitive
- **Ipaddress**: The IP address to give to the VM
- **ClusterSecret**: The value of this field must be the same for all the members of a cluster
- **MasterIps**: If this VM is not the master of the cluster, add the IP address of the master node here
- **SshKeys**: A list of SSH public keys to authorize into the VM. Don't forget to add yours here or you won't be able to reach the node at all

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


## How to log into your VM after deployement


Once the cluster is deployed, you need to connect to one of the nodes and copy the kube-config file.

```shell
ssh rancher@172.30.1.2 # replace with your master node IP
The authenticity of host '172.30.1.2 (172.30.1.2)' can't be established.
ECDSA key fingerprint is SHA256:Q4kQ94B8QaSbo1EsyI8dQrgBkZyk/USda72c8nwVwIE.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '172.30.1.2' (ECDSA) to the list of known hosts.
Welcome to k3OS!

Refer to https://github.com/rancher/k3os for README and issues

By default mode of k3OS is to run a single node cluster. Use "kubectl"
to access it.  The node token in /var/lib/rancher/k3s/server/node-token
can be used to join agents to this server.

k3os-15956 [~]$
```

Let's get all nodes of the cluster

```shell
k3os-15956 [~]$ k3s kubectl get nodes
NAME         STATUS   ROLES    AGE     VERSION
k3os-15956   Ready    master   3m46s   v1.16.3-k3s.2
k3os-15957   Ready    <none>   2m26s   v1.16.3-k3s.2
k3os-15958   Ready    <none>   1m42s   v1.16.3-k3s.2
```

Copy the config so that we can use kubectl from our local machine. By default it is located in `/etc/rancher/k3s/k3s.yaml` on the master node.

Execute this command on your local machine not in a remote shell

```shell
scp rancher@172.30.1.2:/etc/rancher/k3s/k3s.yaml k3s.yaml

> IMPORTANT: Do not forget to update the server IP in the copied yaml file.
> By default, it will be pointing to localhost, this must be changed into the
> IP you used to connect to the VM.
```

If you already have a kube config file usually located in `~/.kube/config`
you can edit it and add the new cluster with the information written on k3s.yaml

Here is an example of `~/.kube/config`

```yaml
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: LS0tLS1CRUdLKjhdDGhjDHKHKhDBJWakNCL3FBREFnRUNBZ0VBTUFvR0NDcUdTTTQ5QkFNQ01DTXhJVEFmQmdOVkJBTU1HR3N6Y3kxelpYSjIKWlhJdFkyRkFNVFU0TURjME9EQXhOakFlRncweU1EQXlNRE14TmpRd01UWmFGdzB6TURBeE16RXhOalF3TVRaYQpNQ014SVRBZkJnTlZCQU1NR0dzemN5MXpaWEoyWlhJdFkyRkFNVFU0TURjME9EQXhOakPPOIHjkDHDJHGkFnRUddaW9tdVR1MXQ1aVRlZDhHaVFrQ2FrdnRWL2xpRGJ3MUlxSS94dEkKWmUya2Y3Tm1mL0txR3IrMzN5SVZ5Q0tkaEdlelBCbEsvanNUSkZVSWpzdWpJekFoTUE0R0ExVWREd0DezdzedzenTlZIUk1CQWY4RUJUQURBUUgvTUFvR0NDcUdTTTQ5QkFNQ0EwY0FNRVFDSUJFNTYzcUttY2xiClVQWHc2UXJCbWxQUmlrbWdCVnY0VHlkMVZ0TWNXY3JYQWlCVlJPY3RjMTF1TXFrOGJWVHJOVFNiN0lFS3ZkRjAKelluMzhwME41MdLUVORCBDRVJUSUZJQ0FURS0D=
    server: https://172.30.1.2:6443
  name: k3s
- context:
    cluster: k3s
    namespace: default
    user: k3s
  name: k3s
current-context: k3s
kind: Config
preferences: {}
users:
- name: k3s
  user:
    password: 8719c8d71457366ecaff927cf784
    username: admin
```

or leverage the KUBECONFIG environment variable

```shell
$ export KUBECONFIG=/home/zgo/k3s.yaml
$ kubectl get pods --all-namespaces
$ helm ls --all-namespaces
```

Or specify the location of the kubeconfig file per command:

```shell
kubectl --kubeconfig k3s.yaml get pods --all-namespaces
helm --kubeconfig k3s.yaml ls --all-namespaces
```

