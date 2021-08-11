# Generic Flist solution

This Solution helps to spawn a container using specific Flist provided by the user in the chatflow.

### Inputs

The solution takes some configurations from the user, we will list them and explain their meaning.

- `container name`: A name of your conatiner to help you to get it again with reservation id.
- `Flist link`: The link of your Flist to be deployed. For example: https://hub.grid.tf/usr/example.Flist.
- `environment variables`: Set environment variables on your deployed container, enter comma-separated variable=value For example: var1=value1, var2=value2. Leave empty if not needed.
- `Interactive`: Choose whether you prefer to access your container through the web browser (coreX) or not.
- `IP Address`: Choose the ip address for your Flist.


After the deployment of the Flist is complete, a url will be returned that could be used to access the container through web browser (corex) or by ssh if your Flist support this.

## Deploying a Container with a custom Flist

#### Choosing the solution name
Choosing the name of the solution to be deployed. This allows the user to view the solution's reservation info in the dashboard deployed solutions
![generic_1](img/generic_1.png)

#### Choosing the number of CPU cores and memory size
Specify the number of CPU cores and the size of the memory to be used by the container.
![generic_2](img/generic_2.png)

#### Choose whether you want to attach a volume to the container or not
![generic_3](img/generic_3.png)
- If `Yes`, You need to choose the volume size and its mount point in the next step.
![generic_3](img/generic_31.png)

#### Select pool for your solution to be deployed on
![generic_4](img/generic_4.png)

#### Select network for your solution to be deployed on
![generic_5](img/generic_5.png)

#### Flist link
The Flist link added is used to create the container from it. The link is from the Flist uploaded on the hub
![generic_6](img/generic_6.png)

#### Using corex
The corex option allows the user to access the container through corex. If disable the user could access the container using ssh
![generic_7](img/generic_7.png)

#### Select node or leave it empty
Here we could provide a node id corresponding to a node on the grid to deploy the container on. This node has to be part of your Capacity pool.
![generic_8](img/generic_8.png)

#### Choose whether you want to push the container logs onto an external redis channel or not
![generic_9](img/generic_9.png)

#### Choosing the private IP address of the container
Choosing the private IP address that will be used to access or communicate with the deployed solution.
![generic_11](img/generic_11.png)

#### Choosing environment variables
If the container needs any env variables on startup, they are passed through this option where they are in the format `variable=value` seperated by commas.
![generic_12](img/generic_12.png)

### Choose whether you want to assign a global Ipv6 address for your container or not
![generic_13](img/generic_13.png)

### Deploying your solution
![generic_15](img/generic_15.png)

#### Successfully deployed
![generic_16](img/generic_16.png)

#### Access solution info from the Generic Flist solution page
![Step9](img/generic_17.png)
