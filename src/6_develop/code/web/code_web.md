## Using the Web Gateway


### Overview

The aim is to delegate your domain to the gateway, access your running web applications using subdomains of your domain or any managed domains where we need to follow a few steps:

- delegate your domain to a gateway.
- create subdomains using that domain.
- create a tcp reverse proxy on a gateway.

#### Deleagte your domain to a gateway

```python
# throught this document, we'll be using the below gateway for all reservations
GATEWAY_ID = "EwPS7nPZHd5KH6YH7PtbmUpJUyWgseqsqS7cGhjXLUjz"
gateway = j.core.identity.me.explorer.gateway.get(GATEWAY_ID)

# delegate your domain
DOMAIN = "waleed.grid.tf"
reservation = j.sals.zos.reservation_create()
j.sals.zos._gateway.delegate_domain(reservation=reservation, node_id=gateway.node_id, domain=DOMAIN)

expiration = j.data.time.utcnow().timestamp + (5*60*60)
response = zos.reservation_register(reservation, expiration)
time.sleep(5)


```


# Create Subdomains using that domain
```python
SUBDOMAIN = f"srv5.{DOMAIN}"
gateway_ips = []
for ns in gateway.dns_nameserver:
    gateway_ips.append(j.sals.nettools.get_host_by_name(ns))

reservation = j.sals.zos.reservation_create()

# the subdomain will be pointing to the gateway node so we can use it to expose a workload using the tcp reverse proxy
j.sals.zos._gateway.subdomain(reservation=reservation, node_id=gateway.node_id, domain=SUBDOMAIN, ips=gateway_ips)
expiration = j.data.time.utcnow().timestamp + (5*60*60)
response = zos.reservation_register(reservation, expiration)
time.sleep(5)

```


# Create a tcp reverse proxy on a gateway
```python
import uuid
SECRET = f"{j.core.identity.me.tid}:{uuid.uuid4().hex}"

reservation = j.sals.zos.reservation_create()
j.sals.zos._gateway.tcp_proxy_reverse(reservation=reservation, node_id=gateway.node_id, domain=SUBDOMAIN, secret=SECRET)
expiration = j.data.time.utcnow().timestamp + (5*60*60)
response = zos.reservation_register(reservation, expiration)
time.sleep(5)

```

now you can expose any workload using `trc` flist url: https://hub.grid.tf/tf-official-apps/tcprouter:latest.flist by creating a container with entrypoint

```
entrypoint = f"/bin/trc -local {SOLUTION_IP_ADDRESS}:{SOLUTION_PORT} -local-tls {SOLUTION_IP_ADDRESS}:{SOLUTION_TLS_PORT}" f" -remote {gateway_ips[0]}:{gateway.tcp_router_port}"
```

and set `TRC_SECRET` environment variable to the tcp reverse proxy secret
