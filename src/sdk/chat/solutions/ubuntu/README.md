# Ubuntu
A free and open-source Linux distribution based on Debian.
Ubuntu is officially released in three editions: Desktop, Server, and Core(for internet of things devices and robots). This package is used to deploy an ubuntu container from an official flist on the grid using a chatflow.

## Accessing the solution

Go to your admin dashboard `https://localhost:4000/admin` and click on Network

![solutions menu](./../adminmenu.png)


## Inputs

- `container name` a name of your container to help you to get it again with reservation id.
- `Ubuntu version`: choose ubuntu version flist for your container
- `cpu needed` : Number of cpu needed
- `memory size` : Memory size needed example 2048
- `ssh key` : add your public ssh key `~/.ssh/id_rsa.pub`, if your flist supports using the ssh key from the env variables provided to allow future ssh access
- `environment variables`: set environment variables on your deployed container, enter comma-separated variable=value For example: var1=value1, var2=value2. Leave empty if not needed
- `Expiration time`: a network expiration time (minutes=m ,hour=h, day=d, week=w, month=M)
- `IP Address`: choose the ip address for your ubuntu machine.
* `User setup`
- register user threebot on explorer ```kosmos "j.tools.threebot.init_my_threebot(name=3bot_NAME,email=EMAIL)"``` Note: name of 3bot is (your 3bot name).3bot , email is your 3bot email
- Install [wireguard](https://www.wireguard.com/install/)


After the deployment of the ubuntu is complete, a url will be returned that can be used to access the container through web browser (corex) after up your wireguard configuration.

## Deploying Ubuntu Container :

### Choosing the network name

![step2](ubuntu2.png)
Choosing the network to be used from a list of existing networks created by the user

### Choosing the solution name

![step3](ubuntu3.png)
Choosing the name of the solution to be deployed. This allows the user to view the solution's reservation info in the dashboard deployed solutions

### Choosing ubuntu version
![step4](ubuntu4.png)
We currently support 18.04 and 16.04


### Choosing Resources for your container
![step5](ubuntu5.png)
Here we specify the CPU and Memory resources allocated for the container

### Authorizing yourself
![step6](ubuntu6.png)
Uploading your public key for SSH access

### Environment variables
![step7](ubuntu7.png)
It's very common that you need to pass some environment variables to your container when starting, if not sure leave empty

### Setting expiration
![step8](ubuntu8.png)
Now we need to tell the grid how long we want our solution to stay alive on the grid

### Choosing IP for the solution
![step9](ubuntu9.png)
Here we choose the IP to access the solution


### Confirm your reservation
![step10](ubuntu10.png)
Here we confirm the specifications we entered in the chatflow


### Reaching your container
![step11](ubuntu11.png)
Here we get the container 



