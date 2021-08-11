# Web Gateway

The 5 primitives provided by the TFGateways are:

- [Domain delegation](capacity_domain_delegation): Allow to delegate all or a part of your own domain to the TFGateway. So you could create sub-domain directly from the TFGateway.
- [Subdomain](capacity_subdomain): Allow to create A or AAAA DNS record on a domain managed by the TFGateway.
- [TCP proxy](capacity_tcp_proxy): Generic TCP proxy service. Allows you to forward traffic coming to the TFGateway and forward it to another IP address.
- [Reverse tunnel TCP proxy](capacity_reverse_tcp_proxy): Another mode for TCP proxy: https://github.com/Threefoldtech/tcprouter#reverse-tunneling
- [VNP Gateway service IPv4 to IPv6](capacity_gw4to6): Since the grid runs primarily on IPv6. This primitive creates a VPN that allow user to access IPv6 through the TFGateway.
