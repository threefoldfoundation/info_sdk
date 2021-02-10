# Monitor Kubernetes clusters 

<!-- TODO GEERT
- intro: explain what you can monitor in terms of k8s monitoring
- intro: explain what you can do either monitoring online or locally
- getting started: at the end add link to vdc_monitoring_stack.md
- getting started:  add link to monitoring_local.md

------------>

The health of the VDC you deploy can be monitored. A stack has been prepared that offers monitoring through Prometheus and Grafana. 

The scope of Kubernetes is very large, and each of these components can be monitored: the master and worker nodes (in terms of CPU consumption, memory usage, disk space usage, ...), but also the kubelet, pods, workloads, ... 

## Getting Started

> For monitoring using the stack solution on the ThreeFold Grid, please read [__Monitoring Stack__](evdc_monitoring_stack).

> For monitoring on your local machine, please read [__Monitoring Local__](evdc_monitoring_local).