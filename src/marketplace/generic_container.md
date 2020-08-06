# Generic flist solution

This Solution helps to spawn a container using specific flist provided by the user in the chatflow.

### Accessing the solution


![generic_1](././img/generic_1.png)



### Inputs

The solution takes some configurations from the user, we will list them and explain their meaning

- `container name` : a name of your conatiner to help you to get it again with reservation id.
- `Flist link` : the link of your flist to be deployed. For example: https://hub.grid.tf/usr/example.flist
- `environment variables`: set environment variables on your deployed container, enter comma-separated variable=value For example: var1=value1, var2=value2. Leave empty if not needed
- `Expiration time`: a network expiration time (minutes=m ,hour=h, day=d, week=w, month=M)
- `Inetractive`: choose whether you prefer to access to your container through the web browser (coreX) or not.
- `IP Address`: choose the ip address for your ubuntu machine.



After the deployment of the flist is complete, a url will be returned that can be used to access the container through web browser (corex) or by ssh if your flist support this after up your wireguard configuration.

### Deploying a Container with a custom flist

![generic_1](././img/generic_1.png)


#### Choosing the solution name

![generic_3](./img/generic_3.png)
Choosing the name of the solution to be deployed. This allows the user to view the solution's reservation info in the dashboard deployed solutions


#### Choosing the network name

![generic_4](./img/generic_4.png)
Choosing the network to be used from a list of existing networks created by the user

#### Flist link

![generic_5](./img/generic_5.png)
The flist link added is used to create the container from it. The link is from the flist uploaded on the hub

#### Choosing the number of CPU cores and memory size

![generic_6](./img/generic_6.png)
Specify the number of CPU cores and the size of the memory to be used by the container deployed

#### Using corex
![generic_7](./img/generic_7.png)
The corex option allows the user to access the container through corex. If disable the user can access the container using ssh


#### Choosing environment variables
![generic_9](./img/generic_9.png)
If the container needs any env variables on startup, they are passed through this option where they are in the format `variable=value` seperated by commas.

#### Choosing the expiration time for the solution
![generic_12](./img/generic_12.png)


Choosing the expiration time for the solution on the grid

#### Choose a farm to deploy on

![generic_10](./img/generic_10.png)

We can choose the farms on which the container can be deployed on. The farms are basically a group of nodes where multiple solutions can be deployed on them. We can either choose the farm name from the drop down list or leave it empty to randomly choose any farm.

#### Choosing the private IP address of the container

![generic_11](./img/generic_11.png)

Choosing the private IP address that will be used to access or communicate with the deployed solution





#### Payment

![generic_14](./img/generic_14.png)

We select the wallet that we will pay with to proceed with the payment for the solution that will be deployed.

#### Deployment info
![generic_16](./img/generic_16.png)