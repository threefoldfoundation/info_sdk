# Kubernetes cluster deployment

This solution is used to deploy a Kubernetes cluster with zdb using a chatflow.


### What is Kubernetes
A [Kubernetes](https://kubernetes.io) cluster is a set of node machines for running containerized applications. At a minimum, a cluster contains a worker node and a master node.

### Accessing the solution

Go to your admin dashboard `https://localhost:4000/admin` and click on Network

![solutions menu](adminmenu.png)


### Inputs

- `container name` a name of your container to help you to get it again with reservation id.
- `number of workers` : number of worker nodes to be deployed, the cluster size will then be the number of workers + 1(master node)
- `ssh keys` : ssh keys which will be used to allow access for the ssh key holders to the deployed cluster. They should be in a file where each ssh key is on a seperate line
- `Expiration time`: a network expiration time (minutes=m ,hour=h, day=d, week=w, month=M)
- `cluster secret` : the secret that will be used to access the cluster deployed. Please keep it safe.
- `IP range` : Configure network manually by choosing an IP range to use or the deployer can choose for you and generate an IP range automatically
- `Network name` : a name for the network to deploy on,  if left empty it will be a generated name


### Deploying Kubernetes:

#### Choosing deployment name
![Step2](k8s2.png)

Choosing the name of the solution to be deployed. This allows the user to view the solution's reservation info in the dashboard deployed solutions

#### Choosing the network
![Step3](k8s3.png)
Here we choose which network we connect our kubernetes cluster to

#### Choosing number of worker nodes
![Step4](k8s4.png)

Here, we specify the number of worker nodes used in the cluster.

#### Uploading your public Key 
![Step5](k8s5.png)
This step is necessary to access the kubernetes machine and authorize you to be able to SSH into it

#### Expiration time
![Step6](k8s6.png)
Here we specify for how long you want to reserve kubernetes cluster on our grid

#### Choosing a secret for the cluster
![Step7](k8s7.png)
Now it's time to choose the secret for your kubernetes cluster, make sure you don't forget it.

#### Set the IP Address for the solution
![Step8](k8s8.png)

After the deployment of the Kubernetes cluster is complete, the user with the ssh keys will have access to the deployed cluster.


Once the user added the wireguard configuration and made sure it is up and running on their machine, they can ssh to the machine using
```bash
ssh rancher@IP_OF_CONTAINER
```
To verify the nodes created on the machine after ssh
```bash
kubectl get nodes
```
![](nodes.png)


## Kubernetes cluster deployment

This solution is used to deploy a Kubernetes cluster with zdb using a chatflow.


In this guide we will walk you through the provisioning of a full-blown kubernetes cluster
on the TF grid.

We will then see how to connect to it and interact using kubectl on our local machine.

Finally we will go through some examples use cases to grasp the features offered by the cluster.

## What is Kubernetes
A [Kubernetes](https://kubernetes.io) cluster is a set of node machines for running containerized applications. At a minimum, a cluster contains a worker node and a master node.

Optionally (if you want to deploy the charts);
- helm (v3) ([install instructions](https://helm.sh/docs/intro/install))
## Accessing the solution

Go to your admin dashboard `https://localhost:4000/admin` and click on Network

![solutions menu](adminmenu.png)


## Inputs

- `container name` a name of your container to help you to get it again with reservation id.
- `number of mater` : number of worker nodes to be deployed
- `number of workers` : number of worker nodes to be deployed, the cluster size will then be the number of workers nodes + number of master nodes
- `ssh keys` : ssh keys which will be used to allow access for the ssh key holders to the deployed cluster. They should be in a file where each ssh key is on a seperate line
- `Expiration time`: a network expiration time (minutes=m ,hour=h, day=d, week=w, month=M)
- `cluster secret` : the secret that will be used to access the cluster deployed. Please keep it safe.
- `IP range` : Configure network manually by choosing an IP range to use or the deployer can choose for you and generate an IP range automatically
- `Network name` : a name for the network to deploy on,  if left empty it will be a generated name

## Deploying Kubernetes:

### Choosing the network

![Step1](k8s3.png)
Here we choose which network we connect our kubernetes cluster to

### Choosing deployment name

![Step2](k8s2.png)

Choosing the name of the solution to be deployed. This allows the user to view the solution's reservation info in the dashboard deployed solutions

### Choosing the nodes specification

![Step4](k8s4.png)
Here we specify the size of the nodes that will be selected for deployment. We also specify the number of master nodes and worker nodes that will be in the cluster

### Choose a farm to deploy on

![step8](farms.png)

We can choose the farms on which to deploy on. The farms are basically a group of nodes where multiple solutions can be deployed on. We can either choose farm names from the drop down list or leave it empty to randomly choose from any farms.

### Uploading your public Key

![Step5](k8s5.png)
This step is necessary to access the kubernetes machine and authorize you to be able to SSH into it

### Expiration time

![Step6](k8s6.png)
Here we specify for how long you want to reserve kubernetes cluster on our grid

### Choosing a secret for the cluster

![Step7](k8s7.png)
Now it's time to choose the secret for your kubernetes cluster, make sure you don't forget it.

### Set the IP Addresses for the solution master nodes

![Step9](k8s8.png)
We select IP addresses equal to the number of master nodes we entered earlier.

### Set the IP Addresses for the solution worker nodes

![Step9](k8s9.png)
We then select IP addresses equal to the number of worker nodes we entered earlier

### Payment

![step10](payment.png)

Finally we select the wallet that we will pay with to proceed with the payment for the solution that will be deployed.

After the deployment of the Kubernetes cluster is complete, the user with the ssh keys will have access to the deployed cluster.

### Connect to the cluster

At this point you should be able to ping your master node and ssh into it.

Check that wg is up and running.

```
$ sudo wg
interface: wg
  public key: vQyDgg9yHp3OsqosDO/Xyutu7efMaCYGmz5JswJvniQ=
  private key: (hidden)
  listening port: 41951

peer: BQE9qUNPKEH59Fy6B2xyMz0KrRfBDIdDm4Bd23ro8DM=
  endpoint: 185.69.166.246:3561
  allowed ips: 172.30.5.0/24, 100.64.30.5/32
  latest handshake: 2 minutes, 43 seconds ago
  transfer: 14.26 KiB received, 19.14 KiB sent
  persistent keepalive: every 20 seconds

```

log into your VM

```
$ ping 172.30.1.2
$ ssh rancher@172.30.1.2
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

```
k3os-15956 [~]$ k3s kubectl get nodes
NAME         STATUS   ROLES    AGE     VERSION
k3os-15956   Ready    master   3m46s   v1.16.3-k3s.2
k3os-15957   Ready    <none>   2m26s   v1.16.3-k3s.2
k3os-15958   Ready    <none>   1m42s   v1.16.3-k3s.2
```

Copy the config so that we can use kubectl from our local machine. By default it is located in `/etc/rancher/k3s/k3s.yaml` on the master node.

Execute this command on your local machine not in a remote shell

```
$ scp rancher@172.30.1.2:/etc/rancher/k3s/k3s.yaml ./k3s.yaml

> IMPORTANT: Do not forget to update the server IP in the copied yaml file.
> By default, it will be pointing to localhost, this must be changed into the
> IP you used to connect to the VM.
```

If you already have a kube config file usually located in `~/.kube/config`
you can edit it and add the new cluster with the informations written on k3s.yaml

here is an example of `~/.kube/config`

```
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

```
$ export KUBECONFIG=/home/zgo/k3s.yaml
$ kubectl get pods --all-namespaces
$ helm ls --all-namespaces
```

Or specify the location of the kubeconfig file per command:

```
kubectl --kubeconfig ./k3s.yaml get pods --all-namespaces
helm --kubeconfig ./k3s.yaml ls --all-namespaces
```

### Delete a Provision

You can delete a provision based on its ID which is returned by `tfuser live`

```
$ ./tfuser live --seed user.seed --end 3000
ID:2587-1 Type:   network expired at:05-Feb-2020 18:02:23state:     ok  network ID:
```

```
$ ./tfuser delete --id 2587-1
Reservation 2587-1 marked as to be deleted
```

## Workload deployment

### Wordpress example

We will launch a wordpress deployment connected to a mysql database.
Let's first create the mysql deployment including a service, a sceret for the DB password and a persistant volume. By default with k3s persistant volume storage class is [local-path](https://rancher.com/docs/k3s/latest/en/storage/)

```
$ cd ressources/wordpress
$ kubectl create -f 1-mysql-pvc.yaml
persistentvolumeclaim/mysql-persistent-storage created
$ kubectl create -f 2-mysql-secret.yaml
secret/mysql-pass created
$ kubectl create -f 3-mysql-deploy.yaml
deployment.apps/mysql created
$ kubectl create -f 4-mysql-svc.yaml
service/mysql created
```

let's do the same for the wordpress deployment

```
$ kubectl create -f 5-wordpress-pvc.yaml
persistentvolumeclaim/wordpress-persistent-storage created
$ kubectl create -f 6-word-deploy.yaml
deployment.apps/wordpress created
$ kubectl create -f 7-wordpress-svc.yaml
service/wordpress created
$ kubectl get po
NAME                         READY   STATUS              RESTARTS   AGE
mysql-5ddb94d667-whpnx       1/1     Running             0          5m48s
wordpress-76f568758d-qdjgn   1/1     Running             0          8s
wordpress-76f568758d-2qhm2   1/1     Running             0          8s
```

Let's connect to the administrator interface through the wordpress NodePort service that we have just created. Let's first retrieve the port open for that service on the nodes

```
$ kubectl get -o jsonpath="{.spec.ports[0].nodePort}" services wordpress
31004
```

We can browse any nodes url on port 31004 to find the wordpress website e.g. [http://172.30.3.2:31004/](http://172.30.3.2:31004/)
and after some setup screens you will access your articles

![wordpress first article](wordpress.png)

### Helm charting

K3s comes with helm support built-in. Let's try to deploy prometheus and grafana monitoring of the cluster through HELM charts.

```
$ kubectl create namespace mon
$ helm install --namespace mon my-release stable/prometheus-operator
$ helm -n mon list
NAME            NAMESPACE       REVISION        UPDATED                                 STATUS          CHART                      APP VERSION
my-release      mon             1               2020-02-04 16:08:41.70990744 +0100 CET  deployed        prometheus-operator-8.5.11 0.34.0
$ kubectl config set-context --current --namespace=mon
$ kubectl get po
NAME                                                     READY   STATUS    RESTARTS   AGE
my-release-kube-state-metrics-778b4d9786-tqp9r           1/1     Running   0          7m34s
my-release-prometheus-node-exporter-xfdgv                1/1     Running   0          7m35s
my-release-prometheus-node-exporter-ngzb4                1/1     Running   0          7m35s
my-release-prometheus-node-exporter-lvmp8                1/1     Running   0          7m35s
my-release-prometheus-oper-operator-69cc584dfb-lxjwp     2/2     Running   0          7m34s
alertmanager-my-release-prometheus-oper-alertmanager-0   2/2     Running   0          7m21s
my-release-grafana-6c447fc4c8-zkc4x                      2/2     Running   0          7m34s
prometheus-my-release-prometheus-oper-prometheus-0       3/3     Running   1          7m10s
```

Let's connect to the grafana interface through the deployment that we have just created.

We setup port forwarding to listen on port 8888 locally, forwarding to port 3000 in the pod selected by the deployment my-release-grafana

```
$ kubectl port-forward deployment/my-release-grafana  8888:3000
Forwarding from 127.0.0.1:8888 -> 3000
Forwarding from [::1]:8888 -> 3000
```

We can browse localhost on port 8888 to find the grafana UI e.g. [http://localhost:8888/](http://localhost:8888/)
The username is `admin` and the default admin password to log into the grafana UI is `prom-operator`
Then you can for instance import a dashboard and use the ID 8588 and don't forget to select the prometheus data source
![kubernetes-deployment-statefulset-daemonset-metrics dashboard](grafana1.png)
or the dashboard ID 6879
![analysis-by-pod](grafana2.png)

## Want to know more ?

head toward our more [advanced documentation](advanced_k8s.md) about the features offered by our kubernetes cluster
