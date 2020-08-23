# Solution Expose

To make your solution available to the internet we provide an option to expose your solution.

This will create a container inside your network which will connect to one of your gateways using [tcprouter](https://github.com/Threefoldtech/tcprouter/) 

Depending on which kind of solution you are trying to expose you might be offered to choose which http port to expose.

1. The chatflow will ask for the kind of solution you want to expose.

![Choose solution kind](./img/solution_expose_choose_kind.png)

2. Pick the solution you want to expose

You will to choose which solution of the previous selected kind you want to expose

![Choose solution](./img/solution_expose_choose_solution.png)

3. Pick the ports you would like to expose for your solution typically this will be your https and http ports (443, 80)

![Choose port](./img/solution_expose_choose_port.png)

4. Next you can choose on which domain you would like to expose your solution this can be a subdomain of either one of your own delegated domains or a subdomain of a gateway provider, it's also possible to enter a custom domain which will required you to make a `cname` dns record towards the nameserver of the gateway

![Choose domain](./img/solution_expose_choose_domain.png)

5. Choose subdomain or custom domain
Note: Currently only direct subdomains are supported no nested domains

![Choose subdomain](./img/solution_expose_choose_subdomain.png)

6. Select the duration of the exposure.

![Choose duration](./img/solution_expose_duration.png)

7. Solution expose payment

![Payment](./img/solution_expose_payment_overview.png)

8. Solution expose result

![Result](./img/solution_expose_result.png)
