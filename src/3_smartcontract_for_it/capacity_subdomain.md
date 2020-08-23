# Sub domain 

This primitives provided by the TFGateway allow a user to create new sub-domain and make them point to their solution.

## Reservation definition

Here is the schema used to define a container reservation:

* **NodeId**: the gateway ID on which to delegate the domain
* **domain**: The full domain you want to create
* **ips**: a list of target IPs. Depending if the IP is an IPv4 or an IPv6, an A or AAAA record will be created accordingly
* **pool_id**: the capacity pool ID to use to provision the workload

## Example using sdk

``` python
zos = j.sals.zos

# This will create an AAAA record that points solution1.TF Grid.zaibon.be to 2a02:2788:864:1314:9eb6:d0ff:fe97:764b
subdomain = zos.gateway.sub_domain(
       node_id='2fi9ZZiBGW4G9pnrN656bMfW6x55RSoHDeMrd9pgSA8T',
       domain='solution1.TF Grid.zaibon.be',
       ips=['2a02:2788:864:1314:9eb6:d0ff:fe97:764b'],
       pool_id=12)

# deploy the workload
id = zos.workloads.deploy(subdomain)
```
