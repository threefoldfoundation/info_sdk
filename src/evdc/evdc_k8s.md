# Docker and Kubernetes

The IT industry is used to standard tooling for the deployment of their IT workload: 
- Docker is the standard for container
- K8S is the standard for container orchestration
On the TF grid a Kubernetes orchestrator can be deployed out of the box. We have implemented the [K3S](https://k3s.io) implementation, which is full-blown Kubernetes offering, but using only half of the memory footprint, packaged as a single binary and made more lightweight so that it can run in resource-constrained locations (so fit for IoT, edge, ARM etc). 
- For storage, any file system will be supported.

The process for deploying workloads has been made easy as quite a lot of Helm templates have been made available, ready for usage on the grid. 

An easy way to easily manage your Kubernetes clusters is through kubeapps. 

Kubeapps is a web-based UI for deploying and managing applications in Kubernetes clusters.

In the marketplace, there is a widget available to deploy a kubeapps instance. 

![](img/evdc_k8s_kubeapps_widget.png)

A few chatflow clicks activates your instance of the application.

![](img/evdc_k8s_kubeapps_dashboard.png)
