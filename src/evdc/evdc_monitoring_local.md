# Monitor K8s clusters Locally using Lens IDE
<!-- to do Geert 
TODO GEERT
- explain what is lens ide , what can it monitor, what's the use / what can it monitor.
- explain requirements
- explain how to set up steps 

--------------->

The health of the VDC you deploy can be monitored. 
Next to the Prometheus/Grafana online monitoring stack, you can also set up monitoring from your local computer, as an example through the [Lens](https://k8slens.dev/) IDE. 

Lens is an IDE for people who need to deal with Kubernetes clusters on a daily basis. It is a standalone application for MacOS, Windows and Linux operating systems. 

- It ensures your clusters are properly setup and configured. 
- It gives increased visibility, real time statistics, log streams and hands-on troubleshooting capabilities. 


### Requirements
- Lens IDE can be used on MacOS, Windows and Linux

### How to configure your TFGrid Kubernetes cluster in Lens 

To configure the K8S into Lens, you need to download the VDC `Kubeconfig` file. 

![](img/evdc_k8s_monitoring_12_kubeconfig.png)

Import this file into the IDE.

![](img/evdc_k8s_monitoring_13_lens_kubeconfig.png)

And you're done !

![](img/evdc_k8s_monitoring_14_lens.png)
