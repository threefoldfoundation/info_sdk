# Monitor K8s clusters 

The health of the VDC you deploy can be monitored. A stack has been prepared that offers monitoring through Prometheus and Grafana. A Helm chart `kube-prometheus-stack` is available, which offers Prometheus and Grafana as tooling to monitor your VDC. 

## Monitoring Walkthrough

The monitoring stack is available as a solution in the marketplace. 

![](./img/evdc-k8s-monitoring-01-mktpl.png)

Click `Deploy` and go through a simple chatflow to configure the monitoring on your cluster. 

![](./img/evdc-k8s-monitoring-02-mktpl2.png)

A few elements need to be provided. 
First give your monitoring the name you want (will be part of the url).

![](./img/evdc-k8s-monitoring-03-name.png)

You can configure the url to be auto-generated, or part of your own domain. 

![](./img/evdc-k8s-monitoring-04-subdomain.png)

This information is enough to prepare the Monitoring Stack. 

![](./img/evdc-k8s-monitoring-05-deploying.png)

Choose the size of the hardware to be reserved for your monitoring solution. 

![](./img/evdc-k8s-monitoring-06-flavour.png)

Now there is enough information to set up the monitoring stack on your Kubernetes cluster. 

![](./img/evdc-k8s-monitoring-07-init.png)

And that's it: the url's are available to access your monitoring solution, with both UIs on Prometheus and Grafana. 

![](./img/evdc-k8s-monitoring-08-success.png)

![](./img/evdc-k8s-monitoring-09-prometheus.png)

![](./img/evdc-k8s-monitoring-09-grafana1.png)

![](./img/evdc-k8s-monitoring-11-grafana3.png)

Alternatively you can also set up monitoring from your local computer, as an example through the [Lens](https://k8slens.dev/) IDE. To configure the K8S into Lens, you need to download the VDC `Kubeconfig` file. 

![](./img/evdc-k8s-monitoring-12-kubeconfig.png)

Import this file into the IDE.

![](./img/evdc-k8s-monitoring-13-lens-kubeconfig.png)

And you're done !

![](./img/evdc-k8s-monitoring-14-lens.png)
