## Kubernetes cluster deployment

This solution is used to deploy a Kubernetes cluster with zdb using a chatflow.


In this guide we will walk you through the provisioning of a full-blown kubernetes cluster
on the TF Grid.

We will then see how to connect to it and interact using kubectl on our local machine.

Finally we will go through some examples use cases to grasp the features offered by the cluster.



## What is Kubernetes
A [Kubernetes](https://kubernetes.io) cluster is a set of node machines for running containerized applications. At a minimum, a cluster contains a worker node and a master node.

Optionally (if you want to deploy the charts);
- helm (v3) ([install instructions](https://helm.sh/docs/intro/install))

## Steps for deployment

### Choosing solution name
Choosing the name of the solution to be deployed. This allows the user to view the solution's reservation info in the dashboard deployed solutions
![k8s_1](./img/k8s_1.png)

### Choosing the nodes flavors
Here we specify the size of the nodes that will be selected for deployment. We also specify the number of master nodes and worker nodes that will be in the cluster
![k8s_2](./img/k8s_2.png)

### Select the pools for your nodes
![k8s_3](./img/k8s_3.png)

### Choosing network
Here we choose which network we connect our kubernetes cluster to
![k8s_4](./img/k8s_4.png)

### Uploading your public Key
This step is necessary to access the kubernetes machine and authorize you to be able to SSH into it
![k8s_5](./img/k8s_5.png)

### Choosing a secret for the cluster
Now it's time to choose the secret for your kubernetes cluster, make sure you don't forget it.
![k8s_6](./img/k8s_6.png)

### Set the IP Addresses for the solution master nodes
We select IP addresses equal to the number of master nodes we entered earlier.
![k8s_7](./img/k8s_7.png)

### Set the IP Addresses for the solution worker nodes
We then select IP addresses equal to the number of worker nodes we entered earlier
![k8s_8](./img/k8s_8.png)

### Deploying your solution
![k8s_9](./img/k8s_9.png)

### Successfully deployed. You can access the cluster
![k8s_10](./img/k8s_10.png)
![k8s_11](./img/k8s_11.png)