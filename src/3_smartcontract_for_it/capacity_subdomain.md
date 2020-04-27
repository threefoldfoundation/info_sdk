# Sub domain 

This primitives provided by the TFGateway allow a user to create new sub-domain and make them point to their solution.

## Reservation definition

Here is the schema used to define a container reservation:

- **NodeId**: the gateway ID on which to delegate the domain
- **domain**: The full domain you want to create
- **ips**: a list of target IPs. Depending if the IP is an IPv4 or an IPv6, an A or AAAA record will be created accordingly

## Example using sdk


```python
zos = j.sal.zosv2

# create a reservation
r = zos.reservation_create()

# This will create an AAAA record that points solution1.tfgrid.zaibon.be to 2a02:2788:864:1314:9eb6:d0ff:fe97:764b
zos.gateway.sub_domain(reservation=r,
                            node_id='2fi9ZZiBGW4G9pnrN656bMfW6x55RSoHDeMrd9pgSA8T',
                            domain='solution1.tfgrid.zaibon.be',
                            ips=['2a02:2788:864:1314:9eb6:d0ff:fe97:764b'])
```