# Reverse tunnel TCP proxy

This primitives provided by the TFGateway allow a user to forward traffic from the public internet to a hidden service that has not public address at all. 

The way it works is on the hidden client side, a small client runs and opens a connection to the tcp router server. The client sends a secret during an handshake with the server to authenticate the connection.

The server then keeps the connection opens and is able to forward incoming public traffic to the open connection. This is specially useful if there is no way for the tcp router server to open a connection to the backend. Usually because of NAT.

![reverse_tunnel](reverse_tunnel.png)

## Reservation definition

Here is the schema used to define a container reservation:

- **NodeId**: the gateway ID on which to delegate the domain
- **domain**: The domain to forward traffic from
- **secret**: The secret used by the TCP router client when initiating the connection to the Gateway. 
The secret needs to have a specific format: `<threebot_id>:<random>`.  
If my threebot_id is `123`, a valid secret would be `123:chieb7roi9oongah9shukuupeiChaeph`.

## Example using sdk

```python
zos = j.sal.zosv2

# create a reservation
r = zos.reservation_create()

zos.gateway.tcp_proxy_reverse(reservation=r,
                            node_id='2fi9ZZiBGW4G9pnrN656bMfW6x55RSoHDeMrd9pgSA8T',
                            domain='solution1.tfgrid.zaibon.be',
                            secret='123:chieb7roi9oongah9shukuupeiChaeph')
```

## Remark

To use this primitive you need to make sure that the container you run have the [TCP Router client](https://github.com/threefoldtech/tcprouter/tree/master/cmds/client) available.

There is an flist with the TCP router client included ready to use at https://hub.grid.tf/tf-official-apps/tcprouter:latest.flist.md
You can merge this flist into yours to have a complete solution.
