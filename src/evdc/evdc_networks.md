# Set up a network in the Kubernetes cluster

Set up a network for interconnecting the different Kubernetes pods and volumes comes out of the box with Kubernetes (and available in the K3S implementation). 

Please check in the Kubernetes Network Policies on how to establish a network, interconnecting pods and expose it to the outside world using ingress (version 2.3 of traefik available in our configuration, with tcp forwarding) and egress. 