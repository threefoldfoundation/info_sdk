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

![k8s_1](./img/k8s_1.png)

![k8s_2](./img/k8s_2.png)

### Choosing deployment name
![k8s_3](./img/k8s_3.png)

Choosing the name of the solution to be deployed. This allows the user to view the solution's reservation info in the dashboard deployed solutions

### Choosing network
![k8s_4](./img/k8s_4.png)
Here we choose which network we connect our kubernetes cluster to



### Choosing the nodes specification

![k8s_5](./img/k8s_5.png)
Here we specify the size of the nodes that will be selected for deployment. We also specify the number of master nodes and worker nodes that will be in the cluster
![k8s_6](./img/k8s_6.png)

### Uploading your public Key
![k8s_7](./img/k8s_7.png)
This step is necessary to access the kubernetes machine and authorize you to be able to SSH into it


![k8s_8](./img/k8s_8.png)


### Choosing a secret for the cluster

![k8s_9](./img/k8s_9.png)
Now it's time to choose the secret for your kubernetes cluster, make sure you don't forget it.

### Expiration
![k8s_10](./img/k8s_10.png)
Here we specify for how long you want to reserve kubernetes cluster on our grid


### Set the IP Addresses for the solution master nodes

![k8s_11](./img/k8s_11.png)
We select IP addresses equal to the number of master nodes we entered earlier.

### Set the IP Addresses for the solution worker nodes

![k8s_12](./img/k8s_12.png)

We then select IP addresses equal to the number of worker nodes we entered earlier


### Confirm your reservation
![k8s_13](./img/k8s_13.png)
Here we confirm the specifications we entered in the chatflow

### payment
![k8s_14](./img/k8s_14.png)
Finally we select the wallet that we will pay with to proceed with the payment for the solution that will be deployed.

After the deployment of the Kubernetes cluster is complete, the user with the ssh keys will have access to the deployed cluster.

### Deployment information
![k8s_15](./img/k8s_15.png)

### Accessing the cluster
![k8s_16](./img/k8s_16.png)
![k8s_17](./img/k8s_17.png)