# Packages

Packages are the way to write extensions and applications to your 3Bot server and it can be driven by an optional package.py file which controls the life cycle of the application including install, uninstall,start .. etc.

Content:
- [Structure](#structure)
 - [Mandatory components](#mandatory-components)
 - [Optional components](#optional-components)
- [Configuration](#configuration)
 - [Servers](#servers)
- [More about packages](#more-about-packages)
- [Package manager](#package-manager)
- [Adding new packages](#adding-new-packages)
 - [Add the package to the 3Bot server](#add-the-package-to-the-3Bot-server)
 - [Add the package using package manager actor](#add-the-package-using-package-manager-actor)


## Structure
A package is a self contained code where you define the configurations, the API endpoints, and your database models. It should have the same structure that we will go through in the upcoming sections
```
hello
├── actors
│ └── helloActor.py
├── chats
│ └── helloChatflow.py
├── package.py
├── package.toml
└── __init__.py
```

Some components will be defined by default based on the parent package classes if not provided in the package while other components have to be included in the package when loading it to the jumpscale server.

### Mandatory components
- **package.toml** is where the package information is defined such as its name, ports, and type of content for example static website.<br />
 Example
 ```
 name = "chatflows"
 ports = [ 80,443]

 [[static_dirs]]
 name = "frontend"
 path_url = "/static"
 path_location = "frontend"
 ```

 We can also define bottle server to start in the toml file like in the following example

 ```
 [[bottle_servers]]
 name = "main"
 file_path = "bottle/bottle.py"
 path_url = "/"
 path_dest = "/"
 host = "0.0.0.0"
 port = 8552
 ```

 Other servers locations can also be defined, for example using codeserver
 ```
 [[servers.locations]]
 type = "proxy"
 host = "127.0.0.1"
 name = "codeserver"
 port = 8080
 path_url = "/codeserver"
 path_dest = "/"
 websocket = true
 ```
 *Detailed types of `nginx` locations that can be defined inside `package.toml` are documented [here](locations.md).

- **__init__.py** could include the docs that will summarize the use of the package where they are added in the beging of the file in docstrings.

### Optional components

- **package.py** manages the lifecycle of the package.
 - By default, main functionalities are used to start,stop,install..etc the packages.
 - If additional functionalities want to be added during install,uninstall,start of the package in 3Bot server they can be redifined in this file.
 - The basic functions that you can add are included here
  ```python
  from jumpscale.loader import j

  class MyTestPackage:
   @property
   def started(self):
    return self._started

   @property
   def startupcmd(self):
    cmd = j.tools.startupcmd.get("<startupcmd_name>")
    cmd.start_cmd = "<startup_cmd start bash command>"
    return cmd

   def install(self):
    """Called when package is added and installed
    """
    pass

   def uninstall(self):
    """Called when package is deletedand is no longer needed and will be removed from the 3Bot
    """
    pass

   def start(self):
    """Called when 3Bot is started
    """
    pass

   def stop(self):
    """Called when 3Bot stops
    """
    pass
  ```

  If any method is not needed you can omit it. 



- **actors**
 - actors directory contains the logic defined by the package and will be exposed as an API.
 - actor methods can be accessed through `<HOST>/{PACKAGE_NAME}/actors/{ACTOR_NAME}/{ACTOR_METHOD}`.
 - Parent class : `from jumpscale.servers.gedis.baseactor import BaseActor`
 - decorator for actor methods: ``from jumpscale.servers.gedis.baseactor import actor_method`
 <br />
 Example

  ```python3
  from jumpscale.servers.gedis.baseactor import BaseActor, actor_method
  from jumpscale.loader import j

  class HelloActor(BaseActor):
   def __init__(self):
    pass

   @actor_method
   def hello(self):
    return "hello from foo's actor"

  Actor = HelloActor
  ```
 - To know more see [actors](actors.md)

- **chats**
 - chats (chatflows) are interactive communication tools implemented as chatbots where interactive question structures are defined in the parent class
 - chatflows can be accessed through `<HOST>/{PACKAGE_NAME}/chats/{CHATFLOW_NAME}`.
 - Parent class : `from jumpscale.sals.chatflows.chatflows import GedisChatBot`
 - decorator for chatflow methods `from jumpscale.sals.chatflows.chatflows import chatflow_step`
 <br />
 Example
  ```
  from jumpscale.loader import j

  from jumpscale.sals.chatflows.chatflows import GedisChatBot, chatflow_step

  class HelloChatflow(GedisChatBot):
   steps = [
    "step1",
    "step2"
   ]

   @chatflow_step(title="Step1")
   def step1(self):
    self.name = self.string_ask("What is your name?",required=True)

   @chatflow_step(title="Step2")
   def step2(self):
    self.age = self.string_ask("How old are you?",required=True)

  chat = HelloChatflow
  ```
 - To know more see [chatflows](develop_chatflow.md)

## Configuration

Configuration is done in `package.toml`, where you configure servers, bottle apps, chatflows and more.

Manual configuration can be done also on package objects directly in the shell, but it's not recommended.

Example configuration:

```conf
name = "admin"

[[static_dirs]]
name = "frontend"
path_url = ""
path_location = "frontend"
index = "index.html"
spa = true
is_admin = true
```

### Servers
In a package, the server configurations will be mapped to nginx server configuration.

## More about packages

Basic Package functionalities and properties
- Functions
 - load_config()
 - get_bottle_server(file_path, host, port)
 - install()
 - uninstall()
 - start()
 - stop()
 - restart()

- Properties
 - module
 - base_url
 - actors_dir
 - chats_dir
 - static_dirs
 - bottle_servers
 - actors



## Package manager
- `Packages` is an actor on 3Bot under the `admin` package, any user with admin rights can call this actor to remotely instruct the 3Bot to install/remove/start/stop a package from 3Bot server
- A package can be identified by means of git_url or its local path
- The actor methods in the packages actor include:

```python
@actor_method
def get_package_status(self, names: list) -> str:
 return "hello from packages_get_status actor"

@actor_method
def list_packages(self) -> str:
 return j.data.serializers.json.dumps({"data": self.3Bot.packages.get_packages()})

@actor_method
def packages_names(self) -> str:
 return j.data.serializers.json.dumps({"data": list(self.3Bot.packages.list_all())})

@actor_method
def add_package(self, path: str = "", giturl: str = "", extras=None) -> str:
 extras = extras or {}
 if path:
  path = path.strip()
 if giturl:
  giturl = giturl.strip()
 return j.data.serializers.json.dumps({"data": self.3Bot.packages.add(path=path, giturl=giturl, **extras)})

@actor_method
def delete_package(self, name: str) -> str:
 return j.data.serializers.json.dumps({"data": self.3Bot.packages.delete(name)})

```


## Adding new packages
Adding a package can easily be done either through the 3Bot server directly or using the package manager actor mentioned earlier


### Add the package to the 3Bot server

A package can be added directly to the 3Bot server as follows
```python
3Bot_server = j.servers.3Bot.get("<instance_name>") 
3Bot_server.packages.add(<path or giturl>)
3Bot_server.packages.add(path="/home/xmonader/wspace/Threefoldtech/js-ng/jumpscale/packages/hello")
```

```python
➜ js-ng git:(development_3Bot) ✗ curl -XPOST localhost:80/hello/actors/helloActor/hello
"hello from foo's actor"%
```

This also applies to deleting and installing packages directly using the 3Bot server.

### Add the package using package manager actor

After starting the server with the recommended way, the package created can be added using the packages actors which calls the package manager of the 3Bot server. The actor can be called as follows:

```
j.clients.gedis.3Bot.actors.admin_packages.add_package("<path_to_package>")
```
where 3Bot is the gedis instance name for the 3Bot started


