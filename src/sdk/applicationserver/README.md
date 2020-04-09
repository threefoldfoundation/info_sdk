# Threebot Application Server

Threebot is a pluggable application server based on [openresty](https://openresty.org/en/) and gevent servers and comes with lots of goodies by default.
- [Admin Dashboard]
- [Chatflow systems]
- [RPC Server]

## Starting the server
Using  `j.servers.threebot.start()`.

This will give you a ready shell in the same process where you can interact with your threebot:

```
*****************************
*** 3BOTSERVER IS RUNNING ***
*****************************

*** file: /sandbox/lib/jumpscale/Jumpscale/servers/threebot/ThreebotServer.py
*** function: start [linenr:295]

JSX>
```

You can access its admin on https://localhost:4000/admin

## Applications and extensions

Threebot sever can be extended using [packages](packages.md).

## APIs

APIs can be added as actors to your package, which are exposed directly and can be accessed via http or using our `gedis` clients for python or javascript, see [documentation](actors.md).


## Openresty (nginx)

We use openresty (nginx) for serving requests. Inside a package, you can define different types of locations to handle these requests, for more information, check [documentation](locations.md).


- [Packages](packages.md)
- [Actors](actors.md)
- [Locations](locations.md)