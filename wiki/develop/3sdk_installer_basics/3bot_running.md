## Nginx capabilities and advanced running options

After the [installation](3bot_local_install) steps you should have an executable `3Bot`

- in case of pip it should be available for the user
- in case of poetry you need to be in the isolated environment using `poetry shell`

3Bot server could run using `threebot start --local` starts a server on `8443, 8080`. If you want to use `80, 443` ports you need to set capabilities for nginx binary (in case of linux) or install as root in case of OSX

### Setting capabilities for nginx

```
sudo setcap cap_net_bind_service=+ep `which nginx`
```
to be able to run as a normal user, you don't need it if you are root.

- After that we will just do

 ```bash
 threebot start
 ```

- This will take you to configure your identity, It will ask you about your the network you want to use, 3Bot name, email, and words.

- Then it will start 3Bot server you will see some thing like that

 ![configure](img/identity_new.png)

- After success you could visit the admin dashboard at http://localhost and start creating reservations


- After success you could visit the admin dashboard at http://localhost and start creating reservations

 ![configure](img/success.png)
 
### Advanced running options 3Bot

- You have some options available to start three bot
```
threebot start <--identity user.3bot> <--background> <--local>
```

if you specified `--indentity user.3bot`, then the passed identity will be the default identity in the running 3Bot

if you specified `--background` then the server will run in background mode

if you specified `--local` then the server will run on ports 8443/https and 8080 https instead of 443/https and 80/http
