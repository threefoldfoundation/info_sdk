# Capacity layer

TODO: insert graphic

The lowest layer of the ThreefoldGrid is its capacity layer. Raw internet capacity is exposed to the grid through nodes running the [0-OS operating system](https://github.com/threefoldtech/zos).

0-OS provides 4 primitives that can be combined together to build full applications.

The 5 primitives available at the moment are:

- [0-DB namespace](0-DB.md): low lever key-value store
- [Container volume](volume.md): direct access to raw disk from a container
- [Container](container.md): allow to run application inside containers
- [Overlay network](network.md): overlay network to connect all the primitives between nodes
- [Kubernetes cluster](k8s_cluster.md): full kubernetes cluster