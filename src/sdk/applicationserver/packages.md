Package is the way to write extensions and applications to threebot server and it is driven using `package.py` file which controls the life cycle of the application, including configurations (prepare) , start, stop .. etc.

![workflow](images/workflow.png)


## Creating a new package

a package is a self contained code where you define the configurations, the API endpoints, and your database models. It should have the same structure that we will go through in the upcoming sections 
```

3BOTDEVEL:3bot:tmp: tree hello/
hello
├── actors
│   └── hello.py
├── chatflows
│   └── hello.py
├── models
├── package.py
├── package.toml
└── wiki
```


## Package structure
- **models directory** registers the model on the package loading. There is no need to manually add the models

    _note_: Crud model actors are automatically generated and added to the package actors, to disable this option add `disable_crud = true` to the package.toml file
- **actors directory** 
    - is registered automatically when loading the package. There is no need to manually add actors, they can be accessed via http at `3BOT_URL/<threefold_name>/<package_name>/actors/<actor_name>/<actor_method>`.
    - is the logic inside a package
    - the code inside an actor should call as much as possible libraries in jumpscale (sals, clients, ...)
    - is also the implementation of our api for this package to the outside world, our interface basically
- **wiki directory** 
    - is loaded automatically and can be accessed via `3BOT_URL/<threefold_name>/<package_name>/wiki`.
    - how to use wiki check [wiki](https://github.com/threefoldtech/jumpscaleX_threebot/blob/development/docs/wikis/README.md)
- **chatflows directory** 
    - is loaded automatically, can be access via `3BOT_URL/<threefold_name>/<package_name>/chat`.
    - interactive communication, implemented as chat bots
    - each file inside is a chat bot
- **html**
    - adds html in `http(s)://$threeboturl/$packagename/` 
    - you can add simple static html pages 
- **frontend**
- you can add a fully functional website using frontend framework (example ```Svelte``` or ```Vue.js```) that can use the package
- **package.py**  is where the  package logic is defined.

    For packages that need their own bcdb, you need to override bcdb property like this

    ```python
    class Package(j.baseclasses.threebot_package):
        @property
        def bcdb(self):
            return self.threebot_server.bcdb_get("your_name")

        ...
    ```
- **package.toml**  is where the package information is defined, such as bcdb's and actors' namespaces.

All of these except **package.py** and **package.toml** are optional and other loading logic can be used they will be automatically loaded, do not do manually.


## Package basic functions
Please do not put any load/install/uninstall logic on any other location.

The basic functions that you can override there 
```python
class Package(j.baseclasses.threebot_package):

    def _init(self, **kwargs):
        #if you want to initialize something you might need for your package, is optional !!!
        self.actors_namespace = "someothernamespace" #default is 'default' can overrule like this
        self.giturl = ...

    @property
    def bcdb(self):
        #is the default implementation, if you want to overrule, provide this method
        return self.threebot_server.bcdb_get("$packagename")

    def prepare(self):
        """
        is called at install time
        :return:
        """
        #use this to e.g. checkout git files use
        codepath = j.clients.git.getContentPathFromURLorPath(urlOrPath=self.giturl, pull=True, branch=None):
        #e.g. when you have developed a website can use this to check out the git code
        #the codepath will be where the code is checked out        
        #can now e.g. 

    def install(self):
        """
        called when the 3bot will install your package
        """
        pass

    def start(self):
        """
        called when the 3bot starts
        :return:
        """
        #std will load the actors & models & the wiki's, no need to specify
        #you can leave it empty or add specific configuration you want to specify
        self.openresty.install()
        self.openresty.configure()

        for port in (443, 80):
            default_website = self.openresty.get_from_port(port)
            locations = default_website.locations.get(name=f"admin_{port}")

            admin_location = locations.get_location_static("admin")
            admin_location.path_url = "/admin"
            admin_location.path_location = f"{self._dirpath}/output"
            admin_location.is_auth = True

            # another website/server config for /
            root_website = self.openresty.websites.get(f"admin_root_{port}")
            root_website.port = port
            root_website.ssl = port == 443
            root_locations = root_website.locations.get(name=f"admin_root_{port}")

            root_location = root_locations.get_location_static("admin_home")
            root_location.path_url = "/"
            root_location.path_location = f"{self._dirpath}/output"
            root_location.is_auth = True
            # include default website locations
            root_include_location = root_locations.get_location_custom("admin_home_includes")
            root_include_location.config = (
                f"include {default_website.path_cfg_dir}/{default_website.name}_locations/*.conf;"
            )

            default_website.configure()
            root_website.configure()

    def stop(self):
        """
        called when the 3bot stops
        :return:
        """
        if not j.sal.fs.exists("{DIR_BIN}/code-server"):
            j.builders.apps.codeserver.install()
        self.startupcmd.stop()


    def uninstall(self):
        """
        called when the package is no longer needed and will be removed from the threebot
        :return:
        """
        # TODO: clean up bcdb ?
        pass
```

If method is not needed you can omit it. 

## Package properties
properties available in the package object
```python
self.package_root =     #path of this dir
self.gedis_server =     #gedis server which will serve actors in this package
self.openresty =        #openresty which is active in the threebot server
self.threebot_server =  #the threebot server itself
self.rack_server =      #the gevent rackserver dealing with all gevent greenlets running in a gevent rack
self.bcdb =             #can be overruled by you (is a property), default is the system bcdb
```

## Locations
Detailed types of `openresty/nginx` locations that can be defined inside are documented [here](locations.md).

## Authentication
We provide oauth2 proxy and clients, see [documentation](oauth2/README.md) of how you can use them inside your package.

## Example package.toml

```toml
[source]
name = "demo"
description = "mypackage"
threebot = "zerobot"
version = "1.0.0"

[actor]
namespace = "zerobot"

[[bcdbs]]
name = "zerobot_demo"
namespace = "zerobot_demo"
type = "zdb"
instance = "default"
```

## Example package.py


- Packages does the lifecycle management of your application
- Package.py file which is read when a package get's loaded.
- This is the ONLY file which deals with installing, start/stop, remove a package from a 3bot.


typical `package.py` should look like

```python
from Jumpscale import j


class Package(j.baseclasses.threebot_package):
    pass

```

In case you wanted to do more, creating proxies, special locations .. etc it may look like the following

```python
from Jumpscale import j


class Package(j.baseclasses.threebot_package):
    def setup_locations(self):
        """
        ports & paths used for threebotserver
        see: {DIR_BASE}/code/github/threefoldtech/jumpscaleX_core/docs/3Bot/web_environment.md
        will start bottle server web interface which include (gedis http interface, gedis websocket interface and
        bcdbfs web server)
        endpoints:
        "/web/gedis/http"       >    gedis htto interface
        "/web/gedis/websocket"  >    gedis websocket interface
        "/web/bcdbfs"           >    bcdbfs web server
        "/weblibs"              >    static jumpscale weblibs files
        """

        self.openresty.configure()

        # get our main webserver
        for port in (443, 80):
            website = self.openresty.get_from_port(port)

            # PROXY for gedis HTTP
            locations = website.locations.get(name="webinterface_locations")

            package_actors_location = locations.locations_proxy.new()
            package_actors_location.name = "package"
            package_actors_location.path_url = "~* /(.*)/(.*)/actors/(.*)/(.*)$"
            package_actors_location.ipaddr_dest = "127.0.0.1"
            package_actors_location.port_dest = 9999
            package_actors_location.path_dest = ""
            package_actors_location.type = "http"
            package_actors_location.scheme = "http"

            ## more code omitted.


            website.configure()

    def start(self):

        # add the main webapplication

        self.setup_locations()

        from threebot_packages.zerobot.webinterface.bottle.gedis import app

        self.gevent_rack.bottle_server_add(name="bottle_web_interface", port=9999, app=app, websocket=True)
        # self.gevent_rack.webapp_root = webapp

```

### Custom configs for package

```
JSX> p.zerobot.chatbot_examples.install(install_kwargs={"mode":"staging"})     
JSX> p.zerobot.chatbot_examples.start()                                        
```


- `self._package.install_kwargs` to can be used to access the `install_kwargs` in `package.py`
- `self.package.install_kwargs` can be used to access the `install_kwargs` in the actors


## Package manager
is an actor on threebot, any user with admin rights can call this actor to remotely instruct his 3bot to install/remove/start/stop a package
package can be identified by means of git_url
if the package is already on the server (normally not the case) can use the path

```python
def package_add(self, git_url=None, path=None):
    """
    can use a git_url or a path
    path needs to exist on the threebot server
    the git_url will get the code on the server (package source code) if its not there yet
    it will not update if its already there
    """

def package_delete(self, name):
    """
    remove this package from the threebot server
    will call package.uninstall()
    """

def package_stop(self, name):
    """
    stop a package, which means will call package.stop()
    """

def package_start(self, name):
    """
    start a package, which means will call package.start()
    """
```

## Registering package

### TODO: add package manager UI or link to admin package manager.

#### Using package manager actor

After starting the server with the recommended way, the package created can be added using the package manager (It's implemented as a package too and loaded by default):

Directly from threebot shell:

```
j.threebot.packages.zerobot.packagemanager.actors.package_manager.package_add(path='/sandbox/code/github/threefoldtech/jumpscaleX_threebot/ThreeBotPackages/zerobot/alerta')
```

Or through a client from another process:

```
kosmos -p
JSX> cl = j.clients.gedis.get(name="pm", port=8901, package_name="zerobot.packagemanager")
JSX> cl.reload()
JSX> cl.actors.package_manager.package_add(path='/sandbox/code/github/threefoldtech/jumpscaleX_threebot/ThreeBotPackages/zerobot/alerta')
```
