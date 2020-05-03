# Solution Expose

To make your solution available to the internet we provide an option to expose your solution.

This will create a container inside your network which will connect to one of your gateways using [tcprouter](https://github.com/threefoldtech/tcprouter/) 

Depending on which kind of solution you are trying to expose you might be offered to choose which http port to expose.

1. The chatflow will ask for the kind of solution you want to expose.

![Choose solution kind](solution_expose_choose_kind.png)

2. Pick the solution you want to expose

You will to choose which solution of the previous selected kind you want to expose

3. In case the solution kind is not kubernetes or minio you get to pick which port you would like to expose

4. Next you can choose on which domain you would like to expose your solution this can be a subdomain of either one of your own delegated domains or a subdomain of a gateway provider, it's also possible to enter a custom domain which will required you to make a `cname` dns record towards the nameserver of the gateway

5. Select the duration of the exposure.

6. Deployment or payment will follow
