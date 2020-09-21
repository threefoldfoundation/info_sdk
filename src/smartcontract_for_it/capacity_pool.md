# Capacity pool

The capacity pool has been introduced to solve some issues related to the way
payments work on the TF Grid. Specifically, because payment is done for the
entirety of the reservation and forwarded immediately to the farmer, there is no
way to cleanly recover funds in case something goes wrong post deployment. Although
the capacity pool was originally conceived as a way to extend a reservation, we
also used the opportunity provided by its introduction to solve some of these issues.

## Technical overview

In order to understand how the pool works, we first need to understand how a
reservation and payment is tied together. Before the pool concept, a single
reservation was paid in full before deployment. After the payment was done, the
nodes would attempt to deploy the reservation. If all individual workloads were
successful, the payment would be forwarded to the farmers. If any workload failed
to deploy, all of them would be cancelled, and the client is refunded for the full
amount.

To calculate how much a reservation actually costs, and how much each farmer
receives, we sorted the workloads per farm, converted a workload into an amount
of CU and SU it would consume. With the CU and SU price, calculated the final
cost for the client. The important takeaway here, is that regardless of the exact
workload, you actually pay for the resources which will be consumed by your reservation,
and the time, for which your reservation would be alive.

Now that we understand that the reservation is actually converted to a constant
usage of capacity, we could think of a reservation as consuming a certain amount
of CU and SU per second, i.e. some CU/s and SU/s. If we take this concept and isolate
it from the reservation, we come to the capacity pool. Rather than paying for a
reservation, you now pay for an amount of capacity, which can be deployed on some
nodes. A pool has a certain amount of CUs and SUs available, which allow a reservation
to use 1 CU and SU, respectively, for 1 second. As such, a reservation which
requires 2 CU and 0 SU, for example, will consume 2 CUs and 0 SUs per second.

In this regard, old style reservations can be thought of as having an implicit
capacity pool attached to each workload individually. The problem there was, that
since it was an implicit pool, rather than an explicit one such as the ones we
introduced now, there was no way to reuse the pool. This meant that, if the workload
died, the pool also died.

Since the pool is now a standalone object, we can easily link workloads to it,
simply by referencing the pool ID in the workload. Simultaneously, the pool keeps
track of all workloads which are associated with it, as well as the amount of CU
and SU these workloads consume, per second. If a new workload is deployed, this amount
increases, meaning the amount of CUs and SUs in the pool will decrease at a faster
rate, and likewise, if a workload is cancelled, the amount of CU and SU in use
will decrease, meaning the pool will last longer. If a pool runs out of either,
we can easily cancel all active workloads using the pool. If a client wants
to extend reservations on the other hand, he can just buy more CUs and SUs for his
pool, which then extends the remaining time before the pool is empty.

Capacity is paid for in full once it is bought. In this way, payment happens
similarly to the old reservation system. However, if your workload dies after 5
minutes, and it was reserved for a whole month, your pool will still have roughly
a month of capacity left to be used by a new workload of similar size.

## Recap

To summarize, the capacity pool keeps an amount raw capacity, which can be deployed
on certain nodes. Increasing the amount of workloads tied to a pool will cause
it do empty faster, while removing obsolete workloads will cause it to last longer
with the workloads which are still relevant. Overall, if the pool ever does run
out, all workloads attached are cancelled, so make sure to keep your pools supporting
important workloads filled.
