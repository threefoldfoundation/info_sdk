### How to get started with the SDK

#### Prerequisites
The prerequisites of getting started with the SDK are:
- you got yourself the 3bot.connect app in the apple or google play store
- you have installed the Jumpscale SDK on your laptop.  (installation instructions here: [linux](https://github.com/threefoldfoundation/info_threefold/blob/development/docs/wikieditors/installation_linux.md) or [macos](https://github.com/threefoldfoundation/info_threefold/blob/development/docs/wikieditors/installation_macos.md))

If you have not got these things done please go to the "Getting started session".

#### How to work with the SDK

There are numerous ways to use the SDK and use the TF Grid.  We will mention two ways which are the two ones we prefer.  Obviously you might find other methods work better for you.

1. Chat
2. Code
3. Blockchain

The Jumpscale SDK is inclusive of everyone that has the- interest to create and deploy on the TF Grid. It presents three ways of communicating one needs for the novice, intermediate and experienced developers.  Also these 3 ways to create and innovate are present with different interfaces.

##### User the graphical administration panel

After installing on a local system there should be a 3bot SDK start with an SDK admin panel.  To connect to it you should connect to the IP address on which the docker container is operating.  
    1. For a local system install there is a port forwarding to the `localhost` allowing you to do this `[http://localhost:7000'](http://localhost:7000).  
    2. If you have installed in a virtual machine running ubuntu on your localhost you should be able to connect to the IP address of the VM.  Same format 'http://<< IP-address-of-the-VM >>:7000

The following screen should welcome you:

![SDK login](tab_explanation/img/SDK_login.png)

Use the 3bot.Connect application to login.

![SDK admin panel](tab_explanation/img/SDK_admin_panel.png)

Included in the SDK is a Visual Studio editors which allows you to edit and create scripts, packages and Jumpscale code to your IT architectures up and running.
![Codeserver](tab_explanation/img/codeserver.png)

##### Login the container and use the CLI interface
You can also login into the container and use the available CLI interface to manage code and execute code.

```
root@virbuntu:~# docker ps
CONTAINER ID        IMAGE                 COMMAND             CREATED             STATUS              PORTS                                                                                                                                                                                                               NAMES
dc8489006ed8        threefoldtech/3bot2   "/sbin/my_init"     4 hours ago         Up 4 hours          0.0.0.0:9001->9001/udp, 0.0.0.0:9000->22/tcp, 0.0.0.0:7000->80/tcp, 0.0.0.0:4000->443/tcp, 0.0.0.0:9005->8005/tcp, 0.0.0.0:9006->8006/tcp, 0.0.0.0:9007->8007/tcp, 0.0.0.0:9008->8008/tcp, 0.0.0.0:9009->8009/tcp   3bot
root@virbuntu:~# ssh localhost -p 9000 -A
OK
3BOTDEVEL:3bot:~: ipython
Python 3.7.5 (default, Nov 20 2019, 09:21:52)
Type 'copyright', 'credits' or 'license' for more information
IPython 7.13.0 -- An enhanced Interactive Python. Type '?' for help.

In [1]:
```
in this container you can do all the usual git repository management, use the Jumpscale libraries to create TF Grid deployments, reservations and payments.