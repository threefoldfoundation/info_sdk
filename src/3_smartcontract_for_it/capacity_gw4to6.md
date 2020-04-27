# VPN 4To6 Gateway

This primitives allows any user that has not access to the IPv6 network to get a wireguard configuration that he can use to enable him to access IPv6.

The idea behind this primitive is to try to allow everyone to access the grid, which runs primarily on IPv6.

## Reservation definition

- **NodeId**: the gateway ID on which to create the VPN
- **publicKey**: a wireguard public key


## Example using sdk

```python
zos = j.sal.zosv2

# create a reservation
r = zos.reservation_create()

zos.gateway.gateway_4to6(reservation=r,
                         node_id='2fi9ZZiBGW4G9pnrN656bMfW6x55RSoHDeMrd9pgSA8T',
                         public_key="Zzfi3yTPtHMPF0JtjQ3wKpmeEch7G86X1NC5Qwvx0Sc='
                         secret='123:chieb7roi9oongah9shukuupeiChaeph')
```
