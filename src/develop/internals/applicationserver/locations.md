# Locations
As you already figured out we use `openresty` for running applications, serving content and proxying requests based on the URL pattern:

Inside a package, you could define one of the following location types:

- [Static:](#static)
- [Single page apps (SPA)](#single-page-apps-spa)
- [Proxy](#proxy)
- [Custom](#custom)
- [Threebot Connect](#threebot-connect)


## Static:
Used to serve static assets directly (should use that for your css, js, images). The configuration as follows is simply added to the `package.toml`

```bash
[[static_dirs]]
name = "<location name>"
path_url = "static"
path_location = "<static files location>"
index = "index.html"
```

## Single page apps (SPA)
A special location to serve SPA (e.g. sapper exported) directories mainly.

Adding the following example to the package's `package.toml` creates a SPA location that serves the build directory.

```bash
[[static_dirs]]
name = "<location name>"
path_url = "static"
path_location = "<static files location>"
index = "index.html"
```

## Proxy
To `proxy` requests on certain location to a running server.

The following example create a proxy on `<location_path>` when added to the `package.toml`

```bash
[[servers.locations]]
type = "proxy"
host = "<host>"
name = "<location name>"
port = "<proxy_port>"
path_url = "<location_path>"
path_dest = "<destination_path>"
websocket = true
## optional to enable proxy buffering by nginx
proxy_buffering = "on"
proxy_buffers = "8 256k"
proxy_buffer_size = "256k"
```

## Custom
You could add there whatever configurations you want. Simply by adding the following to the `package.toml` with the type as *custom*.

```bash
[[servers.locations]]
type = "custom"
name = "<location_name>"
custom_config = """
location / {
 rewrite ^/(.*)/path$ /path/$1;
}
"""
```

## 3Bot Connect

- In case you need your locations authenticated by 3Bot connect which is the default you need to add to the `package.toml` the following
```
is_auth=true
```
- Otherwise to disable it then add the following
```
is_auth=false
```

- To disable 3Bot login totally use in js-ng shell:
```python
j.core.config.set('threebot_connect', False)
```

- To Enable 3Bot login totally use in js-ng shell:
```python
j.core.config.set('threebot_connect', True)
```

Then start 3Bot server.

