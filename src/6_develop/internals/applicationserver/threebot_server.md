# Threebot Server

Threebot server is an application server based on nginx and [gedis](rpc.md). It can further be extended using packages.

When adding packages to a server, they should first be defined, then added to the threebot server then the server can be started.


Content:

- [Threebot Server](#threebot-server)
  - [Staring threebot](#staring-threebot)
    - [Using threebot command](#using-threebot-command)
    - [Manual start](#manual-start)
    - [Nginx and privileged ports](#nginx-and-privileged-ports)
  - [APIs](#apis)
  - [Packages](#packages)
  - [ssl](#ssl)

## Staring threebot

### Using threebot command
`threebot` command can be used to start/stop threebot and to check for current running threebot status. This will give you a ready shell in the same process where you can interact with your threebot:

It can be used to start a threebot server on standard ports (http and https).

```
threebot start
```

In case you need to start a local threebot, ny passing `--local` option will, it will search for free port on `80xx` range and starts threebot on this port.

```
threebot start --local
```

You can then access its admin on https://localhost/admin

### Manual start

Start threebot server from `jsng` shell:

```python
jsng

JS-NG> threebot_server = j.servers.threebot.get(domain="<optional><your-threebotdomain>", email="<your email><required if you want to use domain and ssl for certbot>")
JS-NG> threebot_server.save()
JS-NG> threebot_server.start()
```

It should start nginx for you too, if it's not stared, you can start it manually:

```
sudo nginx -c ~/sandbox/cfg/nginx/main/nginx.conf
```

### Nginx and privileged ports

Most of the times, you'll need to allow nginx to listen on privileged ports (80 and 443):

To increase its capabilities to be able to use port 80 and 443, using this command:

```bash
sudo setcap cap_net_bind_service=+ep `which nginx`
```

## APIs
APIs can be added as actors to your package, which are exposed directly and can be accessed via http or using our `gedis` clients for python or javascript.

*Actors in more detail are documented [here](actors.md).

## Packages
Packages are the way to write extensions and applications to your threebot server and it can be driven by an optional package.py file which controls the life cycle of the application including install, uninstall,start .. etc.

*Packages in more detail are documented [here](packages.md).

## ssl

- If you to generate certificates to your website/package you can specify it in the package.toml explicitly.

for example

```toml
name = "admin"
ports = [80, 443]

[[static_dirs]]
name = "frontend"
path_url = ""
path_location = "frontend/output/"
index = "index.html"
spa = true
is_admin = true

[[servers]]
name = "default"
ports = [80, 443]
domain = "waleed.grid.tf" # your domain name
letsencryptemail = "aa@example.com" # email to get notifications from lets encrypt

[[servers.locations]]
type = "proxy"
host = "127.0.0.1"
port = 80
name = "admin"
path_url = "/"
path_dest = "/admin/"
```

- If you want to have default domain for your threebot, define it in the threebot start

```python
threebot_server = j.servers.threebot.get(domain="<optional><your-threebotdomain>", email="<your email><required if you want to use domain and ssl for certbot>")
threebot_server.start()
```

This will use certbot to generate a certificate for your domain
