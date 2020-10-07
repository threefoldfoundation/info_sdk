# VPN 4To6 Gateway

This primitives allows any user that has no access to an IPv6 network to get a wireguard configuration that he could use to enable him to access IPv6.

The idea behind this primitive is to try to allow everyone to access the grid, which runs primarily on IPv6.

## Reservation definition

* **NodeId**: The gateway ID on which to create the VPN.
* **publicKey**: A wireguard public key.
* **pool_id**: The capacity pool ID to use to provision the workload.

## Example using sdk

``` python
zos = j.sals.zos.get()

workload = zos.gateway.gateway_4to6(gateway_id='2fi9ZZiBGW4G9pnrN656bMfW6x55RSoHDeMrd9pgSA8T',
       public_key="Zzfi3yTPtHMPF0JtjQ3wKpmeEch7G86X1NC5Qwvx0Sc=",
       pool_id=12)

# deploy the workload
id = zos.workloads.deploy(workload)
```
