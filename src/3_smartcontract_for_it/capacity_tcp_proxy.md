# TCP proxy

This primitives provided by the TFGateway allow a user to forward traffic from the public internet inside their private overlay network until services running in container or kubernetes cluster.

## Reservation definition

Here is the schema used to define a container reservation:

- **NodeId**: the gateway ID on which to delegate the domain
- **domain**: The domain to forward traffic from.
- **addr**: The destination address where to proxy the traffic to. This address needs to be reachable by the TFGateway.
- **port**: The listening port of your service handling plain text traffic, usually HTTP
- **port_tls**: The listening port of your service handling TLS traffic, usually HTTPS

## Example using sdk

```python
zos = j.sal.zosv2

# create a reservation
r = zos.reservation_create()

zos.gateway.sub_domain(reservation=r,
                            node_id='2fi9ZZiBGW4G9pnrN656bMfW6x55RSoHDeMrd9pgSA8T',
                            domain='solution1.tfgrid.zaibon.be',
                            addr='2a02:2788:864:1314:9eb6:d0ff:fe97:764b',
                            port=8080,
                            port_tls=4080)
```

## How does the TFGateway find the destination domain from incoming traffic

The TFGateway uses 2 technics to identity the destination domain of incoming request:

- for HTTP, it inspect the `Host` header value
- for TLS traffic is uses [SNI](https://en.wikipedia.org/wiki/Server_Name_Indication)