# Upload Containers to K8S Cluster

Uploading containers can be done using kubectl instruction, but doing it this way brings some inconveniences. Replacing just a couple of values in a file obliges to copy-paste the entire file. 

In order to help with that, we support the use of Helm, a package manager for Kubernetes. It helps to deploy complex application by bundling necessary resources into Charts, which contains all information to run an application on a cluster. 