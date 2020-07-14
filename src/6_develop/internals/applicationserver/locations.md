# Locations
As you already figured out we use `openresty` for running applications, serving content and proxying requests based on the URL pattern:

Inside a package, you can define one of the following location types:

- [Static:](#static)
- [Proxy](#proxy)
- [Single page apps (SPA)](#single-page-apps-spa)
- [Custom](#custom)
    - [Example for custom location](#example-for-custom-location)
- [Conventions for web app directories](#conventions-for-web-app-directories)
- [Serving from domains](#serving-from-domains)
- [Threebot Connect](#threebot-connect)

All `openresty/nginx` configuration files will be generated from this locations, also, there's [a convention for some directories](#conventions-for-web-app-directories) inside a package (if found), also auto-created locations are registered under `<threebot_name>/<package_name>`.

## Static:
Used to serve static assets directly (should use that for your css, js, images).

The following example creates a `/static` location to serve some static files with [weblibs](https://github.com/threefoldtech/jumpscaleX_weblibs).

```python
class Package(j.baseclasses.threebot_package):

    def start():
        website = self.openresty.get_from_port(443)
        locations = website.locations.get("<my locations name>")

        static_location = locations.locations_static.new()
        static_location.name = "<location name>"
        static_location.path_url = "/static"
        static_location.path_location = "<static files location>
        static_location.use_jumpscale_weblibs = True # if set, will copy weblibs and serve it from /static/weblibs directly

        locations.configure()
        website.configure()
```

## Proxy
To `proxy` requests on certain location to a running server.

The following examples create a proxy on `/calendar` which will redirect requests to `0.0.0.0:8851/`, make sure of `ipaddr_dest`, `port_dest`, `path_dest` and `schema` as these are very important for the proxy to work properly.

```python
class Package(j.baseclasses.threebot_package):

    def start():
        wsgi_app = ...  # get for example Bottle.app()
        rack = self.threebot_server.rack_server

        rack.bottle_server_add(name="calendar", port=8851, app=wsgi_app)
        website = self.openresty.get_from_port(443)

        locations = website.locations.get("calendar")
        proxy_location = locations.locations_proxy.new()
        proxy_location.name = "calendar"
        proxy_location.path_url = "/calendar/"
        proxy_location.ipaddr_dest = "0.0.0.0"
        proxy_location.port_dest = 8851
        proxy_location.path_dest = "/"
        proxy_location.scheme = "http"

        locations.configure()
        website.configure()
```

## Single page apps (SPA)
A special location to serve SPA (e.g. sapper exported) directories mainly.

The following example creates a SPA location that serves the build directory of `html`.

```python
class Package(j.baseclasses.threebot_package):

    def start(self):
        server = self.openresty
        website = server.get_from_port(443)
        locations = website.locations.get("myjobs_locations")

        website_location = locations.locations_spa.new()
        website_location.name = "myjobs"
        website_location.path_url = "/myjobs"
        website_location.use_jumpscale_weblibs = False
        fullpath = j.sal.fs.joinPaths(self.package_root, "html/")
        website_location.path_location = fullpath

        locations.configure()
        website.configure()
```


## Custom
You can add there whatever configurations you want.

```python
class Package(j.baseclasses.threebot_package):

    def start(self):
        server = self.openresty
        website = server.get_from_port(443)
        locations = website.locations.get("<locations name>")

        website_location = locations.locations_cusotm.new()
        website_location.name = "<location name>"
        website_location.config = """
        location /mypath {
            index index.html
            alias /path/to/files
        }
        """

        locations.configure()
        website.configure()
```

#### Example for custom location

```python
            custom_location = locations.locations_custom.new()
            custom_location.name = "custom"
            custom_location.config = """rewrite ^/(.*)/path$ /path/$1;"""

```

## Conventions for web app directories
- If package has a `frontend` directory, SPA location will be created with the name of the package as `<threebot_name>/<package_name>`.

- If package has a `html` directory, Static location will be created with the name of the package as `<threebot_name>/<package_name>`.

## Serving from domains

To serve a website from domain directly, you need to create a new server config with this domain.

If you need the main server config, which is created by `webinterface` package to handle wikis, gedis and others, you should include it.

Also, you can rewrite all requests of package route to `/` instead of `/<threebot name>/<package name>`, using rewrite directive like:

```conf
    location / {
        rewrite ^(.+) /mythreebot/mypackage;
    }
```

A full `package.py` example:

```python
import re
from Jumpscale import j


DOMAIN = "my.domain.test"


class Package(j.baseclasses.threebot_package):
    def start(self):
        for port in (443, 80):
            website = self.openresty.websites.get(f"my_website_{port}")
            website.port = port
            website.ssl = port == 443
            website.domain = DOMAIN
            locations = website.locations.get(name=f"my_website_{port}_locations")

            include_location = locations.locations_custom.new()
            include_location.name = f"my_website_includes_{port}"
            # default website locations include wiki related locations
            # so include them
            default_website_name = self.openresty.get_from_port(port).name
            include_location.config = f"""
            include {website.path_cfg_dir}/{default_website_name}_locations/*.conf;

            location / {{
                rewrite ^(.+) /mythreebot/mypackage;
            }}"""

            locations.configure()
            website.configure()

```

Here we get the name of the main website/server locations config (you can get it by doing `self.openresty.get_from_port`, and include all locations of it.

```python
    default_website_name = self.openresty.get_from_port(port).name
    include_location.config = f"""
    include {website.path_cfg_dir}/{default_website_name}_locations/*.conf;
    ...
```

Some points to take care of:
* If your website has a frontend/SPA, you need to set the base path to `/` (instead of `/<threebot name>/<package name>`).
* when testing locally using `hosts` file, use `.test` as a top level domain, so that browsers don't ignore it.

## Threebot Connect

- In case you need your locations authenticated by 3Bot connect in each location you can add

    ```python
    website_location.is_auth = True
    ```

    to locations configuration in `package.py`

- To disable threebot login totally in the conatiner for debugging purposes use:

```python
j.tools.threebot.threebotconnect_disable()
```

- To Enable use:

```python
j.tools.threebot.threebotconnect_enable()
```


Then start 3Bot server.

