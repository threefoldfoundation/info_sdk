### How to get started with the SDK

#### Prerequisites
The prerequisites of getting started with the SDK are:

- you got yourself the 3bot Connect app in the apple or google play store
- you have installed the TFGrid SDK on your laptop.  (installation instructions here: [linux](https://github.com/threefoldfoundation/info_threefold/blob/development/docs/wikieditors/installation_linux.md) or [macos](https://github.com/threefoldfoundation/info_threefold/blob/development/docs/wikieditors/installation_macos.md))

If you have not got these things done please go to the "Getting started session".

#### How to work with the SDK

There are numerous ways to use the SDK and use the TF Grid.  We will mention two ways which are the two ones we prefer.  Obviously you might find other methods that work better for you.

1. Chat
2. Code
3. Blockchain

The TFGrid SDK is inclusive of everyone that has the interest to create and deploy on the TF Grid. It presents three ways of communicating one needs for the novice, intermediate and experienced developers.  Also these 3 ways to create and innovate are present with different interfaces.



##### Use the graphical administration panel

After installing on a local system there should be a 3bot SDK start with an SDK admin panel.  To connect to it you should connect to the IP address on which the Docker container is operating.  
    1. For a local system install there is a port forwarding to the `localhost` allowing you to do this `[http://localhost:7000'](http://localhost:7000).  

The following screen should welcome you:

![SDK login](tab_explanation/img/SDK_login.png)

Use the 3bot Connect application to login.

![SDK admin panel](tab_explanation/img/SDK_admin_panel.png)


Included in the SDK is a Visual Studio editors which allows you to edit and create scripts, packages and Jumpscale code to your IT architectures up and running.
![Codeserver](tab_explanation/img/codeserver.png)

##### Login the container and use the CLI interface
You can also login into the container and use the available CLI interface to manage code and execute code.

```bash
3sdk
```

then do
```
container shell
```

this will give you a shell into the container.

In this container you can do all the usual Git repository management, use the Jumpscale libraries to create TF Grid deployments, reservations and payments.
