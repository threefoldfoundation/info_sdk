# Domain delegation

This primitives provided by the TFGateway allow a user to delegate the management of its domain to the TFGateway itself.
Delegating allows to create sub-domain directly from the TFGateway.

## Reservation definition

Here is the schema used to define a container reservation:

* `gateway_id`: The gateway ID on which to delegate the domain (part of the contract)
* `domain`: The domain you want to delegate.

## Example using sdk

``` python
zos = j.sals.zos.get()

# add domain delegation reservation into the reservation
delegated = zos.gateway.delegate_domain(gateway_id='2fi9ZZiBGW4G9pnrN656bMfW6x55RSoHDeMrd9pgSA8T',
          domain='tfgrid.zaibon.be',
          pool_id=12)

# deploy the workload
id = zos.workloads.deploy(delegated)
```

One extra step to finalize the delegation of the domain is to configure your domain NS record so they point to the
address of the TFGateway.

Each Gateway reports the domain that needs to be used to configure the NS record of the delegated domain.

![gateway nameserve](./img/gateway_nameserver.png)

Once you have found the TFGateway domain, go to your own domain management system and add an NS record that points to the domain of the TFGateway like so:

![ns record](./img/ns_record.png)
