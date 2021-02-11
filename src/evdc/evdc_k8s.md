# Docker and Kubernetes
<!-- TO DO geert
- intro: explain in short what is kubernetes cluster and how it relates to TF evdc Compute nodes. 
- intro: show when you upgrade a computer node, it means youre deploying kubernetes cluster. 
- explains the sizes of kubernetes cluster,  
- add link on how to add compute nodes at the end. (evdc_compute) -->

The IT industry is used to standard tooling for the deployment of their IT workload: 
- Docker is the standard for containers
- Kubernetes is the standard for container orchestration

On the TF Grid a Kubernetes orchestrator can be deployed out of the box. We have implemented the [K3S](https://k3s.io) implementation, which is a full-blown Kubernetes offering, but using only half of the memory footprint, packaged as a single binary and made more lightweight so that it can run in resource-constrained locations (so fit for IoT, edge, ARM etc). 

A VDC is in essence a Kubernetes cluster with a master node and different worker nodes, plus an IP address to expose the workload to the public internet. 

In the below screenshot, the VDC contains one master node and 2 worker nodes. 

![](./img/evdc_compute_nodes.png)

Any tooling for managing your Kubernetes cluster, both for workload provisioning and monitoring, can be provided with the offering in the marketplace. 

> Please read [__Kubeapps__](evdc_kubeapps) section to deploy and manage applications in your Kubernetes cluster. 

> Please read [__Monitoring__](evdc_monitoring_k8s) to deploy monitoring tools on your Kubernetes cluster. 

The process for deploying workloads has been made easy as quite a lot of Helm templates have been made available, ready for usage on the grid. 

For storage, any file system will be supported.

