# 3Bot Admin Panel Overview

The 3Bot Admin Panel is a versatile platform to administrate, monitor, and control processes and activities on the Threefold Grid. As the features and capabilities of our product are expanding, we're taking great measure to make sure that your experience of running projects and solutions on top of the Threefold Grid is as intuitive and frictionless as possible.

The admin panel has 2 viewing options, light and dark mode. You can switch between both using the slider on the top bar. 

### Sidebar

The sidebar allows to navigate easily between the different features offered within this admin panel. Each of the features is shortly explained below and in this wiki. 

### Dashboard

 It provides “at-a-glance” visibility into active resources, shows system versions, network (testnet, mainnet), processes status, memory consumptions, pools and some health checks. 

![./img/threebot_admin_dashboard.png](./img/threebot_admin_dashboard.png)

### Wallets
Your 3Bot comes in handy with a built-in [__3Bot Wallets__](3bot_wallet.md), listing all your existing 3Bot wallets, with the option to create a new wallet or import an existing one from the Stellar network (mainnet or testnet, aligned with the network that hosts your 3Bot). 

Please go to [__3Bot Wallets__](3bot_wallet.md) to learn more.

### Capacity Pools
Your 3Bot comes in handy with a built-in [__Capacity Pools__](3bot_capacity_pools.md) reservation; a feature to reserve capacity on the grid to deploy your solutions on.

Please go to [__Capacity Pools__](3bot_capacity_pools.md) to learn more.

### Package management system
Easy way to install/stop packages available on the filesystem or from a trusted git repository

![packagemanager](./img/packagemanager.png)


### CodeServer code editor

If you want to edit code from the dashboard directly you could do so using CodeServer package.

![codeserver](./img/3bot_admin_codeserver.png)

### Logs
Allows seeing logs per application.

![logs](./img/logs.png)


### Alerts
Advanced alerts system, allowing you to have a view of different alerts as reported (bugs, questions raised and events of different nature). 

![alerts](./img/alerts.jpg)

Check [alerts.md](admin_alerts.md) for info about its actors.

### Details

#### Installation

Admin dashboard is installed by default, you also could install it by path or git url as any other package.

You could view the dashboard by navigating to `http://<host>/admin`.

#### Login

The dashboard is protected by 3Bot connect. To access it in the first place, the user should have started 3Bot server using their saved identity or their 3Bot name was added by the initial user giving them access to the dashboard.

Giving admin access to other users could be done from `Settings` or admins could be added to `j.tools.threebot.me.default.admins` via `jsng` shell:

```python3
j.core.identity.me.admins.append("ahmed.3Bot")
j.core.identity.me.save()
```
![admin_list](./img/admin_list.png)


The user could also choose to use between multiple identities as long as that identity is registered from the 3Bot Connect App. This could be done in the `Settings`as well.
![identity_list](./img/identity_list.png)


#### Extending Admin Dashboard

Please check [extending admin dashboard](admin_extending.md)



