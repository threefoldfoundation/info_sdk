# Domain delegation

This primitives provided by the TFGateway allow a user to delegate the management of its domain the TFGateway itself.
Delegating allow to create sub-domain directly from the TFGateway.

## Reservation definition

Here is the schema used to define a container reservation:

- **NodeId**: the gateway ID on which to delegate the domain
- **domain**: The domain you want to delegate

## Example using sdk

```python
zos = j.sal.zosv2

# create a reservation
r = zos.reservation_create()

# add domain delegation reservation into the reservation
zos.gateway.delegate_domain(reservation=r,
                            node_id='2fi9ZZiBGW4G9pnrN656bMfW6x55RSoHDeMrd9pgSA8T',
                            domain='tfgrid.zaibon.be')
```

One extra step to finalize the delegation of the domain is to configure your domain NS record so they point to the
address of the TFGateway.

Each Gateway reports the domain that needs to be use to configure the NS record of the delegated domain.
![gateway nameserve](gateway_nameserver.png)

Once you have found the TFGateway domain, go to your own domain management system and an NS record that points to the domain of the TFGateway like so:

![ns record](ns_record.png)