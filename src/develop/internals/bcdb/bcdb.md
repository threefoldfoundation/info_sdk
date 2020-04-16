# Block Chain Database (BCDB)

Traditional Block chain databases, are slow, not efficient in many use cases.
BCDB is a database that utilizes many concepts used by today's Block chains while trying to be more
efficient and fasr in the same time

## Features
- Gevent basesd, no locking, all transactions go through gevent, and processed sequentially in so fast manner
- Schema based
    - Schema is not forced physically
    - Very simple to write compared to the way schemas are written in traditional orms

        | Mongoengine  | BCDB  |
        |---|---|
        |  `Class User(Document):`<br>    `email = StringField(required=True)`<br>`first_name = StringField(max_length=50)`<br>`last_name = StringField(max_length=50)` |  `@url = jumpscale.helloworld.user`<br>`email = (S)`<br>`first_name = (S)`<br>`last_name = (S)`
     |

  - Rich data types of data types that are not even supported by traditional databases including numeric data type which accepts currencies and does transparent conversion to different currencies including bitcoin, etc, ..
    - List, Dictionary, Guid,
    Path,
    Boolean,
    Integer,
    Float,
    String,
    Bytes,
    StringMultiLine,
    IPRange,
    IPPort,
    Tel,
    YAML,
    MSGPACK,
    JSON,
    Email,
    Date,
    DateTime,
    Duration,
    Numeric,
    Percent,
    Set,
    CapnpBin,
    JSXObjectTypeFactory,
    Url,
    Enumeration,
    IPAddress
  - there are abbreviations for data types inside a schema and you can reference other schemas like you do with a foreign key in traditional orms forexamples
    ```
    url = 'jumpscale.example.1'
    name = (S)  # string
    numeric = (N) # currency
    integer_list = L(I) # list of integers
    inferred_type = ""  # this will be automatically detected as a String (S) data type
    url = 'jumpscale.example.2'
    example1 = (O) !jumpscale.example.1    # an object of type jumpscale.example.1 defined above
    ```

  - Each schema id defined by a unique URL which you can get schema using it
  - Schemas are `capnp` serializable, it means low memory fingerprint, fast processing and they can be copied remtely easily, i,e
    a client can download schemas quickly for auto completion, etc
  - A schema is used to create a model object which represents the item that needs to be saved

- From schema you can have a model, which allows for CRUD operations, and creating new records
- built in Encryption
- Indexing
  - use `**` after field name in schema to force indexing i.e `name** = (S)`
- Full Text Search
  - use `***` after field name in schema to support full text search on that field i.e `description*** = (S)`
- Support for hooks or triggers
- Name spaces
- modular architecture, you can choose one of different backends, and the proper indexing engine


## Architecture

- **Storage layer**
  - Key/Value Store Backends (Redis, 0-DB or Sqlite)
  - Key/Value stores are not data types aware, they save keys and values are just binary data
    that is why we need an indexing layer that is data type aware

- **Indexing layer**
  - SQLITE (very fast)

- **Full text Search**
   - Sonic Server (fast)

- **Caching layer**
  - Redis (very fast caching)

## Components

![BCDB components](img/BCDB_components.png)


### Quick Beginners guide

You need to define the backends for bcdb, then add schema to the database
then from schem you get a model tied to that schema and from model
you could create new objects to be saved or search databse or delete , etc, ..


**Start Backends (0-db & Sonic)**
- A quick way to do so is
    ```
  JSX> j.data.bcdb.start_servers_test_zdb_sonic(reset=True)

    no server running need to start
    ++ '[' start == kill ']'
    ++ tmux -f /sandbox/cfg/.tmux.conf has-session -t main
    no server running on /tmp/tmux-0/default
    ++ '[' 1 -eq 1 ']'
    ++ echo 'no server running need to start'
    ++ tmux -f /sandbox/cfg/.tmux.conf new -s main -d 'bash --rcfile /sandbox/bin/env_tmux_detach.sh'
    ++ '[' start '!=' start ']'
    (
    ## jumpscale.sonic.server.1
    ID: 6
     - name                : testserver
     - host                : 127.0.0.1
     - port                : 1,492
     - adminsecret_        : 123456
     - timeout             : 300
    ,
    ## jumpscale.zdb.server.1
    ID: 1
     - name                : testserver
     - addr                : 127.0.0.1
     - port                : 9,901
     - adminsecret_        : 123456
     - executor            : tmux
     - mode                : seq
    )
   ```

**Get the storclient for the backend**
- If you start test servers as indicated above you can do
  ```
   storclient = j.clients.zdb.testserver
  ```

**Create database instance**
- Create test database : `test_db = j.data.bcdb.get(name="test_zdb", storclient=storeclient)`
- **Please note** you can do something like `bcdb = j.data.bcdb.get(name="test_db")` without starting any test backends yourself and the database will use the default backend

**Do some playing**



- Add new schema to the Database
    ```
    JSX> schema_text = """
       2     @url = jumpscale.schema.test.a
       3     category**= ""
       4     txt = ""
       5     i = 0
       6     """
    ```
- Get a model from this schema by using its URL
  ```
  model = test_db.model_get(url="jumpscale.schema.test.a")
  ```
- try to find records (empty at the monent)
  ```
  JSX> model.find()
  []
  ```
- Add a object to Database
  ```
    JSX> o = model.new()
    JSX> o.category = "cat"
    JSX> o.txt = "txt"
    JSX> o.i = 10
    JSX> o
    ## jumpscale.schema.test.a
     - category            : cat
     - txt                 : txt
     - i                   : 10

    JSX> o.save()
    ## jumpscale.schema.test.a
    ID: 1
     - category            : cat
     - txt                 : txt
     - i                   : 10
   ```
- Now search database
  ```
    JSX> schema.find()
        [## jumpscale.schema.test.a
        ID: 1

         - category            : cat
         - txt                 : txt
         - i                   : 10
        ]
  ```

### Advanced

- Usually, we need to define our schemas in a `toml` files that contains multiple schemas
and sometimes we need to load schemas from these files
we can load all schemas from toml files in a path

    - **manually** `bcdb.models_add("/sandbox/code/github/threefoldtech/digitalmeX/packages/notary/models")`
    - **Automatically** By default inside 3 a 3bot package, you create a directory called `models` and add your
schema `toml` files there, and it wil be loaded automatically

- **Hooks** There are a lot of use cases for triggers, and basically they are added by defining a function like below in the example and inside the finction you could check for the action you want
   to execute code against i.e `set_post` (after save) or `set_pre` (pre save)

 ```
    JSX> model.trigger_add(lambda model, obj, action, **kwargs: print("Saving") if action == 'set_post' else print('Do nothing'))
    JSX> o = model.new()
    Do nothing
    JSX> o.category = "cat"
    Do nothing
    JSX> o.txt = "txt"
    Do nothing
    JSX> o.save()
    Do nothing
    Saving
    ## jumpscale.schema.test.a
    ID: 3
     - category            : cat
     - txt                 : txt
     - i                   : 0
 ```

**Creating custom indexing example**
Let us assume we have a reservation object which has ```containers``` field which is a list of container objects.
The container object has a single integer field ```node_id``` to refer to the node id which hosts the container.

Our goal is to get all the reservations which has containers hosted on a specific node

```python
bcdb = j.data.bcdb.get(name="reservations")

# defaine reservation schema
reservation_schema = """
@url = jumpscale.reservation.1
containers = (LO) !jumpscale.container.1
"""

# defaine container schema
container_schema = """
@url = jumpscale.container.1
node_id = (I)
"""

container = bcdb.model_get(container_schema)
reservation = bcdb.model_get(reservation_schema)

# define our new index table
class IndexTable(j.clients.peewee.Model):
  class Meta:
    database = None

  pw = j.clients.peewee
  id = pw.PrimaryKeyField(unique=True)
  reservation_id = pw.IntegerField(index=True)
  node_id = pw.IntegerField(index=True)

# define the trigger function
def trigger_func(model, obj, action, **kwargs):
    # Create new record in the index table after storing in BCDB
    if action == 'set_post':
        for container in obj.containers:

            record = model.IndexTable.create(reservation_id=obj.id, node_id=container.node_id)
            record.save()

IndexTable._meta.database = reservation.bcdb.sqlite_index_client
IndexTable.create_table(safe=True)
reservation.IndexTable = IndexTable
# register the trigger function
reservation.trigger_add(trigger_func)
```

Now we can search for the reservations by the container's ```node_id ``` using our index table

```python
c = container.new()
c.node_id = 1

r = reservation.new()
r.containers.append(c)
r.save()

result = reservation.IndexTable.select().where((reservation.IndexTable.node_id == 1)).execute()
assert len(result) == 1
```

### Export/Import

BCDB exposes an export/import functionality.
