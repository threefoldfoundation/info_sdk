# Admin panel overview

![](./img/admin_start.png)

The 3Bot admin panel is a versatile tool to administrate and control processes and activities of the TF Grid SDK.

### Home

Shows system versions, network, processes status, memory consumptions and some health checks

![./img/dashboard.png](./img/dashboard.png)

### Logs
Allows seeing logs per application

![logs](./img/logs.png)


### Alerts
Advanced alerts system

![alerts](./img/alerts.jpg)

check [alerts.md](admin_alerts.md) for info about its actors
### Package management system
Easy way to install/stop packages available on the filesystem or from a trusted git repository

![packagemanager](./img/packagemanager.png)


### Online code editor

If you want to edit code from the dashboard directly you could do so using CodeServer package

![codeserver](./img/codeserverterminal.png)

### Details

#### Installation

Admin dashboard is installed by default, you also could install it by path or git url as any other package.

You could view the dashboard by navigating to `http://<host>/admin`.

#### Login

The dashboard is protected by 3Bot connect. To access it in the first place, the user should have started 3Bot server using their saved identity or their 3Bot name was added by the initial user giving them access to the dashboard.

Giving admin access to other users could be done from `Settings` or admins could be added to `j.tools.3Bot.me.default.admins` via `jsng` shell:

```python3
j.core.identity.me.admins.append("ahmed.3Bot")
j.core.identity.me.save()
```
![admin_list](./img/admin_list.png)


The user could also choose to use between multiple identities as long as that identity is registered from the 3Bot connect app. This could be done in the `Settings`as well.
![identity_list](./img/identity_list.png)


#### Extending Admin Dashboard

Please check [extending admin dashboard](admin_extending.md)



