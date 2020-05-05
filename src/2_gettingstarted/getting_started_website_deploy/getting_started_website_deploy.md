# Deploy your first website

In this section we will guide you through the steps required to be able to host your website.

We will start by creating an flist that will include the contents of the website and the server configurations used to serve this content. This flist will be uploaded and hosted on the hub so that it can be used directly in the creation of the container.

This tutorial will be using [Hugo](https://gohugo.io/getting-started/), which is a static site generator to serve the website contents. A simple configuration and basic files will be used.

The tutorial will also use the example "chat flows" to deploy the solution. The chat flows are wizards that guide you through different steps asking you question to help you generate a reservation understandable by the grid. The Generic flist chatflow will be used where the url of the flist we will be creating is used in the process.

## Index

1. [Prepare website content and server](#Prepare-website-content-and-server)
2. [Create flist with website content](#Create-flist-with-website-content)
3. [Deploy container](#Deploy-a-container)
4. [Expose website by configuring web gateway](#Expose-website-by-configuring-web-gateway)

### Prepare website content and server

First we need to prepare the content of the website to be viewed. In this tutorial a one page html file will be used to demonstrate the idea. Feel free to add all your content hoever you like.

We will be using [Hugo](https://gohugo.io/getting-started/) to generate the site. To get the hugo binary follow the next steps

```bash
mkdir hugo_0.69.2_Linux-64bit
cd hugo_0.69.2_Linux-64bit

# get the binary compressed
wget https://github.com/gohugoio/hugo/releases/download/v0.69.2/hugo_0.69.2_Linux-64bit.tar.gz
# get the binary of hugo from the tar folder
tar -xvf hugo_0.69.2_Linux-64bit.tar.gz
cp hugo /usr/bin/
```

This will download and extract the binary `hugo` and the license to use Hugo into the folder you created.
To download a different version of hugo you can visit their [releases page](https://github.com/gohugoio/hugo/releases)

After that we need to create the file structure that will have the contents in. We will create a website with the name `my_hugo_website`.We can also use one of many themes available. The following steps are based on [hugo quick start](https://gohugo.io/getting-started/quick-start/)

```bash
hugo new site my_hugo_website
cd my_hugo_website

# Add theme content
git init
git submodule add https://github.com/budparr/gohugo-theme-ananke.git themes/ananke
# Add theme to configuration
echo 'theme = "ananke"' >> config.toml
```

We will now have the folder `my_hugo_website` created with the following structure
    ![hugo_structure](hugo_structure.png)

We can then add our content under the contents directory or using hugo commands. To test locally just start the server and access it from the browser at  `http://localhost:1313`.

```
hugo new posts/my-first-post.md
# start the server
hugo server -D
```

### Create flist with website content

We are now ready to create our flist. An [flist]() (file list) is an archive to store metadata about a filesystem and can be used on the grid to deploy a container with its contents. The flist should include a startup file as well to indicate if there are any commands to be done once a container is created. In our case we will want to start the hugo server.

We will start by preparing a compressed folder with the hugo binary, the new website we just created, and the startup:

- `bin/hugo`
- `my_hugo_website/`
- `start.sh`

 We can simply create an flist by compressing the contents and uploading them onto the [hub](https://hub.grid.tf/upload) for conversion. We will need to include our startup file that will be used as an entry point in the folder as well. The startup file will be a simple bash file with the following commands to start the server

```bash
#!/bin/sh

cd my_hugo_website
/bin/hugo server -D
```

Now you are ready to tar the contents using 

```bash
tar -czvf my_website_flist_3.tar.gz -C hugo_flist .
```

and upload the it to the [hub](https://hub.grid.tf/upload) once you log in with your 3bot app successfully

![my website flist upload](my_website_flist_upload.png)

Once the upload is complete we now have an flist ready to be used. The flist url we will be using is the source which in our example is
    `https://hub.grid.tf/YOUR_3BOT_NAME.3bot/my_website_flist.flist`

![my website flist upload success](my_website_flist_upload_success.png)

### Deploy a container

Now that we have our flist ready, we are prepared to deploy a container on the grid. To be able to do so you will need to make sure of the following:

- You have a 3bot identity registered on the TFgrid
- You have tokens that will be used for payment
- You have a deployed network

If any of the previous items is not satisfied you can make sure of them by checking [Deploy your first solution guide](getting_started_first_solution.md). Once you have your network ready we can move on to deploying your container.

1. The first step to deploy the container is to choose the network on which you want to deploy your container. Use the same name you entered previously when creating the network

    ![Choose network](ubuntu_network.png)

2. Second enter a name to give your solution. This will be used locally to save the details of the deployment.

    ![Solution name](my_first_website_solution.png)

3. You then need to enter the link of the flist you created and uploaded on the hub earlier to be provided in the deployment.

    ![Flist link](my_first_website_flist_link.png)

4. Then choose how much CPU and Memory resources you want allocated for the container. You can stick to the default values provided.
    ![Container resources](ubuntu_resources.png)

5. You will then be asked if you want corex running. Since we want the container to be interactive and can be accessed through ssh, then we will disable it and choose `NO`. If enabled, the container will not be accessible through ssh.
    ![Disable corex](my_first_website_corex.png)

6. You now need to provide the entrypoint the container will start with which includes the file you added in your flist to start the server
    ![add entrypoint](my_first_website_entrypoint.png)

7. You can pass any other environment variables that will be used by the flist startup as well incase you chose a different server with different configurations. In this tutorial we don't need to pass anything so you can leave it empty.
    ![Environment variables](chatflows_environment_variables.png)

8. The next step is to choose the expiration time of your reservation. Each capacity reservation made on the grid is always bound to an expiration date. Once the date is reached, the capacity is released back to the grid and your workloads deleted.

    For this tutorial one day will be more then enough. This expiration should include the duration you want the container to live and so the website to be available

    ![Expiration time](chatflow_expiration.png)

9. You can then choose the farms on which the container can be deployed on. The farms are basically a group of nodes where multiple solutions can be deployed on them. You can either choose the farm name from the drop down list or leave it empty to randomly choose any farm. In our case it wont really matter so it can be left empty.

    ![Choose farms](ubuntu_farms2.png)

10. You can now choose an IP address that will be given to your container in your network. This is the ip address you will be using to access the container.

    ![Choose IP](ubuntu_ip.png)

11. Then read carefully the options you selected previously until this point in the chatflow and confirm them by clicking next to proceed with the payment.

12. Now that you have chosen all the resources and details required, you will need to proceed with the payment for the solution that will be deployed. As previously mentioned, you will have your wallet setup and funded with an amount of the currency you chose your network with. The following overview will show the price of the deployment and the details regarding the address to be payed to. By clicking on the wallet you will pay with and then next then you accept the payment to be automatically done from it.

    ![Payment](ubuntu_payments.png)

Once the deployment is successful you should have a container running with the hugo server started to serve your files on port _1313_. In the following section we will configure the web gateway to expose the website to be able to access it.

### Expose website by configuring web gateway
