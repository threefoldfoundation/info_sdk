# TCP proxy

This primitives provided by the TFGateway allows a user to forward traffic from the public internet inside their private overlay network and services running in container or kubernetes cluster.

## Reservation definition

Here is the schema used to define a container reservation:

* **NodeId**: The gateway ID on which to delegate the domain.
* **domain**: The domain to forward traffic from.
* **addr**: The destination address where to proxy the traffic to. This address needs to be reachable by the TFGateway.
* **port**: The listening port of your service handling plain text traffic, usually HTTP.
* **port_tls**: The listening port of your service handling TLS traffic, usually HTTPS.
* **pool_id**: The capacity pool ID to use to provision the workload.

## Example using sdk

``` python
zos = j.sals.zos

proxy = zos.gateway.sub_domain(
       node_id='2fi9ZZiBGW4G9pnrN656bMfW6x55RSoHDeMrd9pgSA8T',
       domain='solution1.TF Grid.zaibon.be',
       addr='2a02:2788:864:1314:9eb6:d0ff:fe97:764b',
       port=8080,
       port_tls=4080,
       pool_id=12)

# deploy the workload
id = zos.workloads.deploy(proxy)
```

## How does the TFGateway find the destination domain from incoming traffic

The TFGateway uses 2 technics to identify the destination domain of incoming request:


* For HTTP, it inspect the `Host` header value.
* For TLS traffic it uses [SNI](https://en.wikipedia.org/wiki/Server_Name_Indication).
