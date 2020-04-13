# Admin dashboard

Admin dashboard UI based on [webix jet](https://webix.gitbook.io/webix-jet/).

## Dependencies

* nodejs & npm
* `cd frontend_src`
* `npm install`

## Development

While development, 3Bot needs to be started with this package installed, then for building the front-end with source maps as a development build, you can use `build_frontend.sh`:

```bash
cd frontend_src && bash build_frontend.sh dev
```

This script will build and copy the output to `frontend` directory to be served as a single page app,then you can go to `http://<host>/admin`.

For production builds, don't pass `dev` to the script:

```bash
bash build_frontend.sh
```

Make sure to push production builds after you finish updating frontend source.

## Structure

* The main entry is [app.js](sources/app.js)
* Views:
  * Main view is defined at [main.js](sources/views/main.js)
  * External views are [wiki](sources/views/wikis), [codeserver](sources/views/codeserver) and [TF-Simulator](sources/views/jupyter).
* Services (calling backend/actors) can be found at [sources/services](sources/services).

## Walktrough creating new component

### MainView

Main view is defined at [main.js](sources/views/main.js) it contains the sidebar stuff and gathers the whole app in it.

### Add entry to sidebar

#### Let's take example `codeserver`:

* Add a directory for your view with under `/sources/views`
*
    ![codeserver](./images/codeserverterminal.png)

* Then in index.js define your view. example

    ```javascript
    import { ExternalView } from "../external";

    const CODE_URL = "/codeserver/?folder=/sandbox/code";
    const REQUIRED_PACKAGES = {
        "zerobot.codeserver": "https://github.com/threefoldtech/jumpscaleX_threebot/tree/development/ThreeBotPackages/zerobot/codeserver"
    }

    export default class CodeserverView extends ExternalView {
        constructor(app, name) {
            super(app, name, CODE_URL, REQUIRED_PACKAGES);
        }
    }
    ```
- Make sure to pass the url of the remote view -in our example its `CODE_URL`-
- If it requires packages to be installed first you define them in `REQUIRED_PACKAGES`
- Just extend `ExternalView` and pass the remote view url `CODE_URL` and required packages `REQUIRED_PACKGGES` to the super
- Now we have the view, to be able to access it we need to add an entry in the sidebar to access it
- in [main.js](sources/views/main.js) there is a list `sidebarData` we can append a view or a view with subviews


```javascript
{
    id: "codeserver",
    value: "Codeserver",
    icon: "mdi mdi-code-tags"
}
```

* this will add a view with id dash (must be the same view directory), and defines icon of from webix





#### Developing a Service

- a service represents a backend webservice `Actor` that has specific functionality that we want to abstract over to use from other parts in our UI.

##### Create your service 

Services are created in `frontend_src/sources/services`

in the following example we will define our `Health` service that we use to check for the health of our application server and its information.

- Create the service in `frontend_src/sources/services/health.js`
```javascript
import { Service } from "../common/api";

const BASE_URL = "/zerobot/admin/actors/health";

class HealthService extends Service {
    constructor() {
        super(BASE_URL);
    }

    getDiskSpace() {
        return this.getCall("get_disk_space");
    }

    getHealth() {
        return this.getCall("health");
    }

    getIdentity() {
        return this.getCall("get_identity");
    }

    getNetworkInfo() {
        return this.getCall("network_info");
    }

    getJsxVersion() {
        return this.getCall("jsx_version");
    }

    getRunningProcesses() {
        return this.getCall("get_running_processes");
    }

    getRunningPorts() {
        return this.getCall("get_running_ports");
    }
}


```
As you noticed all what it does is delegating calls to backend actor `zerobot/admin/actors/health`

Health backend actor is implemented as the following in the application server

```python
from Jumpscale import j

import math
import psutil

# Helper function
def Convert(tup):
    ports = []
    for port, process in tup:
        temp = {}
        temp["port_number"] = port
        temp["process"] = process
        ports.append(temp)
    return ports


STATUS_INSTALLED = 3


class health(j.baseclasses.threebot_actor):
    def _init(self, **kwargs):
        self.gedis_client = j.clients.gedis.get("health_actor", package_name="zerobot.webinterface")

    def _is_installed(self, package_name):
        status = 0
        if j.tools.threebot_packages.exists(package_name):
            status = j.tools.threebot_packages.get(package_name).status.value
        return status == STATUS_INSTALLED

    @j.baseclasses.actor_method
    def network_info(self, schema_out=None, user_session=None):
        container_ip = j.sal.nettools.getIpAddress()
        return container_ip

    @j.baseclasses.actor_method
    def health(self, schema_out=None, user_session=None):
        data = {}

        # bcdb test
        try:
            bcdb = j.data.bcdb.get("test_health")
            scm = """@url = world.ship
            n = 0 (I)
            sub = (O) !world.ship.window

            @url = world.ship.window
            sn = 1 (I)"""

            model = bcdb.model_get(schema=scm)
            obj = model.new()
            obj.n = 1
            obj.sub.sn = 4
            obj.save()
            assert len(bcdb.get_all()) == 1
            bcdb.reset()
            bcdb.destroy()
            data["bcdb"] = "OK"
            self._log_info("TEST OK")
        except Exception as e:
            self._log_error(f"error happend at bcdb: {e}")
            data["bcdb"] = "Error"

        # wikis are running
        try:
            wikis = j.sal.nettools.checkUrlReachable("http://127.0.0.1/mdbook/zerobot.base/#base-package")
            if wikis:
                data["wikis"] = "OK"
            else:
                data["wikis"] = "Error"
        except Exception as e:
            self._log_error(f"error happend at wikis ping: {e}")
            data["wikis"] = "Error"

        if self._is_installed("zerobot.codeserver"):
            # codeserver is running
            try:
                codeserver = j.sal.nettools.checkUrlReachable("http://127.0.0.1:8080")
                if codeserver:
                    data["codeserver"] = "OK"
                else:
                    data["codeserver"] = "Error"
            except Exception as e:
                self._log_error(f"error happend at codeserver ping: {e}")
                data["codeserver"] = "Error"

        if self._is_installed("threefold.simulator"):
            # Jupyter is running
            try:
                jupyter = j.sal.nettools.checkUrlReachable("http://127.0.0.1/threefold/simlator/show/")
                if jupyter:
                    data["jupyter"] = "OK"
                else:
                    data["jupyter"] = "Error"
            except Exception as e:
                self._log_error(f"error happend at jupyter ping: {e}")
                data["jupyter"] = "Error"

        return data

    @j.baseclasses.actor_method
    def get_running_processes(self, schema_out=None, user_session=None):
        """
        Get list of running process sorted by Memory Usage
        """
        all_data = {}
        processes_list = []
        # Iterate over the list
        for proc in psutil.process_iter():
            try:
                # Fetch process details as dict
                pinfo = proc.as_dict(attrs=["pid", "name", "username"])
                pinfo["rss"] = proc.memory_info().rss / (1024 * 1024)
                # Append dict to list
                processes_list.append(pinfo)
            except (psutil.NoSuchProcess, psutil.AccessDenied, psutil.ZombieProcess):
                pass
        processes_list = sorted(processes_list, key=lambda procObj: procObj["rss"], reverse=True)
        all_data["processes_list"] = processes_list

        # memory data
        memory_usage = {}
        memory_data = dict(psutil.virtual_memory()._asdict())
        memory_usage["total_mem"] = math.ceil(memory_data.get("total") / (1024 * 1024 * 1024))
        memory_usage["usage_percent"] = memory_data.get("percent")
        all_data["memory_usage"] = memory_usage
        return j.data.serializers.json.dumps(all_data)

    @j.baseclasses.actor_method
    def get_identity(self, schema_out=None, user_session=None):
        """
        :return: string threebotname
        """
        name = self.gedis_client.actors.identity.threebot_name().name
        return name

    @j.baseclasses.actor_method
    def get_running_ports(self, schema_out=None, user_session=None):
        """
        :return: string threebotname
        """
        data = []
        ports = j.sal.nettools.getRunningPorts()
        unique_ports = list(set(ports))
        data = Convert(unique_ports)
        return j.data.serializers.json.dumps(data)

    @j.baseclasses.actor_method
    def jsx_version(self, schema_out=None, user_session=None):
        """
        ```out
        res = (dict)
        ```
        :return: string threebotname
        """
        _, version = j.clients.git.get(basedir="/sandbox/code/github/threefoldtech/jumpscaleX_core").describe()

        return version

    @j.baseclasses.actor_method
    def get_disk_space(self, schema_out=None, user_session=None):
        res = {}
        disk_obj = psutil.disk_usage("/")
        res["total"] = disk_obj.total // (1024.0 ** 3)
        res["used"] = disk_obj.used // (1024.0 ** 3)
        res["free"] = disk_obj.free // (1024.0 ** 3)
        res["percent"] = disk_obj.percent

        return res

```

- Export an instance of our `HealthService` to be used later on.

```javascript
export const health = new HealthService();

```
##### UI Integration

in `views/dash/health.js`

```javascript

import { JetView } from "webix-jet";
import { health } from "../../services/health";

export default class healthInfoView extends JetView {
    config() {
        const healthInfo = {
            id: "healthInfo",
            responsive: true,
            view: "list",
            responsive: true,
            type: {
                height: 60,
            },
            template: `
            <p><font size="3"><b>#key#: </b></font> #value#</p>
            `
        }

        return {
            type: "space",
            rows: [{
                template: "<div style='width:auto;text-align:center'><h3>Health Checks<h3/></div>",
                height: 50
            },
                healthInfo]
        }
    }
    init(view) {
        var self = this;

        this.healthInfo = this.$$("healthInfo");

        health.getHealth().then(data => {
            data = data.json();

            if (data.bcdb === "OK") {
                self.healthInfo.add({
                    key: "BCDB Status",
                    value: `<span class='webix_icon wxi-checkbox-marked' style="color:green">OK</span>`
                })
            }
            if (data.bcdb === "Error") {
                self.healthInfo.add({
                    key: "BCDB",
                    value: `<span class='webix_icon wxi-close-circle' style="color:red">Error</span>`
                })
            }
            if (data.wikis === "OK") {
                self.healthInfo.add({
                    key: "Wikis",
                    value: `<span class='webix_icon wxi-checkbox-marked' style="color:green">OK</span>`
                })
            }
            if (data.wikis === "Error") {
                self.healthInfo.add({
                    key: "Wikis",
                    value: `<span class='webix_icon wxi-close-circle' style="color:red">Error</span>`
                })
            }
            if (data.codeserver === "OK") {
                self.healthInfo.add({
                    key: "Codeserver",
                    value: `<span class='webix_icon wxi-checkbox-marked' style="color:green">OK</span>`
                })
            }
            if (data.codeserver === "Error") {
                self.healthInfo.add({
                    key: "Codeserver",
                    value: `<span class='webix_icon wxi-close-circle' style="color:red">Error</span>`
                })
            }
            if (data.jupyter === "OK") {
                self.healthInfo.add({
                    key: "Jupyter",
                    value: `<span class='webix_icon wxi-checkbox-marked' style="color:green">OK</span>`
                })
            }
            if (data.jupyter === "Error") {
                self.healthInfo.add({
                    key: "Jupyter",
                    value: `<span class='webix_icon wxi-close-circle' style="color:red">Error</span>`
                })
            }
        });

    }

}


```
and the dash application itself is registerd in `main.js` in sidebarData

```javascript
        const sidebarData = [{
            id: "dash",
            value: "Dashboard",
            icon: "mdi mdi-view-dashboard"
        },

```

#### Subviews 

the last example we are going to talk about is defining subviews (An extension to the dashboard with multiple views)

e.g MyJobs

![myjobs](./images/myjobs.png)


As you can see in the UI that `MyJobs` menu item has two more views `Jobs` and `Workers`

So in `frontend_src/views/myjobs` directory we create `jobs.js` and `workers.js`

`jobs.js`
```javascript

import { JetView } from "webix-jet";

import { dateFormatter } from "../../common/formatters";
import { myjobs } from "../../services/myjobs";

export default class JobsView extends JetView {
    config() {
        const view = {
            view: "datatable",
            id: "jobs_table",
            resizeColumn: true,
            select: true,
            multiselect: true,
            css: "webix_header_border webix_data_border",
            columns: [{
                id: "index",
                header: "#",
                sort: "int",
                autowidth: true,
            },
            {
                id: "category",
                header: "Category",
                sort: "string"
            },
            {
                id: "time_start",
                header: "Start time",
                sort: "date",
                format: dateFormatter,
                width: 200
            },
            {
                id: "time_stop",
                header: "Stop time",
                sort: "date",
                format: dateFormatter,
                width: 200
            },
            {
                id: "timeout",
                header: "Timeout",
                sort: "int"
            },
            {
                id: "action_id",
                header: "Action",
                sort: "string"
            },
            {
                id: "kwargs",
                header: "Arguments",
                sort: "string",
                format: JSON.stringify
            },
            {
                id: "result",
                header: [
                    "Result",
                    {
                        content: "textFilter"
                    }
                ],
                sort: "string",
                format: JSON.stringify,
            }],
            scheme: {
                $init: function (obj) {
                    obj.index = this.count();
                }
            },
        };

        return view;
    }

    init(view) {
        myjobs.listJobs().then(data => {
            view.parse(data);
        });
    }
}
```
and `workers.js`


```javascript
import { JetView } from "webix-jet";

import { dateFormatter } from "../../common/formatters";
import { myjobs } from "../../services/myjobs";

export default class JobsView extends JetView {
    config() {
        const view = {
            view: "datatable",
            id: "workers_table",
            resizeColumn: true,
            select: true,
            multiselect: true,
            css: "webix_header_border webix_data_border",
            columns: [{
                id: "index",
                header: "#",
                sort: "int",
                autowidth: true,
            },
            {
                id: "state",
                header: "State",
                sort: "string"
            },
            {
                id: "halt",
                header: "Halted",
                sort: "string",
                format: function (value) {
                    return value ? 'Yes' : 'No';
                },
            },
            {
                id: "pid",
                header: "PID",
            },
            {
                id: "current_job",
                header: "Current job",
                format: function (value) {
                    return value == 2147483647 ? 'N/A' : value;
                }
            },
            {
                id: "last_update",
                header: "Last update",
                sort: "date",
                format: dateFormatter,
                width: 200
            },
            {
                id: "time_start",
                header: "Start time",
                sort: "date",
                format: dateFormatter,
                width: 200
            },
            {
                id: "timeout",
                header: "Timeout",
            },
            {
                id: "type",
                header: "Type",
            },
            {
                id: "error",
                header: "Error",
            }],
            autoConfig: true,
            scheme: {
                $init: function (obj) {
                    obj.index = this.count();
                }
            },
        };

        return view;
    }

    init(view) {
        myjobs.listWorkers().then(data => {
            view.parse(data);
        });

    }
}

```

and the `main.js` we add the info to the `sidebarData`

```javascript
        {
            id: "myjobs_main",
            value: "My jobs",
            icon: "mdi mdi-animation-play",
            data: [{
                id: "myjobs",
                icon: "mdi mdi-book-open",
                value: "Jobs"
            }, {
                id: "workers",
                icon: "mdi mdi-worker",
                value: "Workers"
            }]
        },
```