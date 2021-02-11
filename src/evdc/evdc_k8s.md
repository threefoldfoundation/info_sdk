# Manage Kubernetes Clusters
<!-- TO DO geert
- V intro: explain in short what is kubernetes cluster and how it relates to TF evdc Compute nodes. 
- V intro: explain when you upgrade a compute node, it means youre deploying kubernetes cluster. 
- V explains the sizes of kubernetes cluster,  
- V add link on how to add compute nodes at the end. (evdc_compute) -->

The IT industry is used to standard tooling for the deployment of their IT workload: 
- Docker is the standard for containers
- Kubernetes is the standard for container orchestration

On the TF Grid a Kubernetes orchestrator can be deployed out of the box. We have implemented the [K3S](https://k3s.io) implementation, which is a full-blown Kubernetes offering, but using only half of the memory footprint, packaged as a single binary and made more lightweight so that it can run in resource-constrained locations (so fit for IoT, edge, ARM etc). 

A VDC is in essence a Kubernetes cluster with a master node and different worker nodes, plus an IP address to expose the workload to the public internet. 

As an example, in the below screenshot the VDC contains one master node and 2 worker nodes. 

![](./img/evdc_compute_nodes.png)

The [Compute Node](evdc_compute) section explains how to add or delete nodes. In essence it means you are deploying or deleting Kubernetes clusters. 

### Manage your cluster 

Any tooling for managing your Kubernetes cluster, both for workload provisioning and monitoring, can be provided with the offering in the marketplace. 

#### Define the Resource limits 

When deploying a solution from the Marketplace, you'll be requested to define the resource sizes, expressed in Mi (for memory) or in m (for CPU). These are Kubernetes units. 

- `Mi` stands for 'mebibytes' and indicates the memory limit that will be used for your container or pod. 
- `m` stands for 'milli CPU' and is the unit representing the CPU allocation. 

A more extended explanation can be found in this nice [article](https://link.medium.com/nl73Mh28Mdb). 

#### Deploy solutions to manage your cluster

> Please read [__Kubeapps__](evdc_kubeapps) section to deploy and manage applications in your Kubernetes cluster. 

> Please read [__Monitoring__](evdc_monitoring_k8s) to deploy monitoring tools on your Kubernetes cluster. 

#### Helm

The process for deploying workloads has been made easy as quite a lot of Helm templates have been made available, ready for usage on the grid. The `Marketplace` widget are created with the help of Helm Charts, which can be found [here](https://github.com/threefoldtech/vdc-solutions-charts), but evidently you can also create your own Helm Charts and deploy them onto your Kubernetes cluster. 
