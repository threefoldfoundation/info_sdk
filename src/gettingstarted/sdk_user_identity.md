#### <a name='StartThreebotContaineronecommand'></a>Start Threebot Container (one command)


> `container threebot`

if you want to set 3botconnect application words `container install words=''`


#### <a name='InstallNewContainer'></a>Install New Container
> `container install name=notsomeuser3 identity=notsomeuser3 email=notsomeuser3@gmail.com server=True`

- server=True means to start 3bot server


#### <a name='RunningNewContainer'></a>Running New Container

to start a new container `container start name:mycontainer`	

#### <a name='ListingContainers'></a>Listing Containers

```
3sdk> container list                                                                                       
 
list the containers 
                                                                                                           
 - notsomeuser3 : localhost       : threefoldtech/3bot2       (sshport:9000)
 - notsomeuser4 : localhost       : threefoldtech/3bot2       (sshport:9010)
 - 3bot       : localhost       : threefoldtech/3bot2       (sshport:9020)
3sdk>  
```
also using the sshport information you can do `ssh root@localhost -p $SSH_PORT` to manually ssh into the 

#### <a name='AccessingContainerShell'></a>Accessing Container Shell

Either use the sshport info from `container list` command and `ssh root@localhost -p $SSH_PORT` or just execute `container shell` and optionally give it the name of your container

#### <a name='GettingContainerKosmos'></a>Getting Container Kosmos

Execute `container kosmos` to get into kosmos shell



### <a name='Advancedfeatures'></a>Advanced features

##### installing 3bot on the host

just `install` in 3sdk

##### Controlling code branches

use `core branch` command



## <a name='Packagedinstallersdk'></a>Packaged installer (sdk)

To build the SDK yourself, you need to have:
* `python3`: `apt-get install python3`
* `pip`: `apt-get install python3-pip`
* `upx` is used to compress binary executable, can be installed with:
    * ubuntu: `apt-get install upx`
    * macos (using brew): `brew install upx`
* `patchelf`: `apt install patchelf`
* `pyinstaller` can be installed using `pip3 install pyinstaller --user`



### <a name='Build:'></a>Build:

Run the packaging script:

```bash
cd install
./package.sh
```

If nothing gone wrong, you should find the final binary executable at `dist` directory.

Try running it with:

```bash
./dist/3sdk
```

## <a name='Using3sdk.pyfromsource'></a>Using 3sdk.py from source
This will require python3, git on the user system 

- `pip3 install jedi pudb ptpython==2.0.4`
- `cd /tmp && git clone https://github.com/threefoldtech/jumpscaleX_core/ && cd jumpscaleX_core && git checkout unstable && git pull`
- `sudo -s`
- `ln /tmp/jumpscaleX_core/install/3sdk.py /usr/bin/3sdk`
 

## <a name='Troubleshooting'></a>Troubleshooting



## <a name='SignatureVerification'></a>signature verification failed, ensure your pubkey to be the same as local configured nacl

```
Tue 14 19:18:01 e/Jumpscale/me/Me.py - 461 - tfgrid_phonebook_register          : EXCEPTION: 
    signature verification failed, ensure your pubkey to be the same as local configured nacl
--TRACEBACK------------------

```

is most likely caused that you registered on phonebook with different words other than the ones in the 3bot connect app

## case you have an old container with your old key and secret
you can get your private key `cat /sandbox/cfg/keys/default/key.priv`
and the secret `cat /sandbox/cfg/jumpscale_config.toml | grep SECRET`


#### Recovering old words (saved)
if you have your key.priv and secret from jumpscale_config and want to restore them



##### Restore estore the key
either copy the file back into `/sandbox/cfg/keys/default/key.priv` or

```
root@3bot:/sandbox# echo -n 'PRIVATEKEYCONTENT' > /sandbox/cfg/keys/default/key.priv
root@3bot:/sandbox# cat /sandbox/cfg/keys/default/key.priv | wc -c
144
```

make sure the length is 144

##### Restore the secret

edit `/sandbox/cfg/jumpscale_config.toml` and set `SECRET` to the old secret.

when done do `jsx check`
##### Retrieve the words 

execute that in kosmos `j.data.nacl.default.words`

NOTE: these words aren't compatible with the keys you have in 3bot connect 

NOTE: You may have to delete `/sandbox/cfg/bcdb_config` and `pkill redis` if you got secret conflicts



### <a name='REMOTEHOSTIDENTIFICATIONHASCHANGED'></a>REMOTE HOST IDENTIFICATION HAS CHANGED

```
Could not execute:    scp -P 9010 root@localhost:/var/executor_data /tmp/jumpscale/scripts/35865.data

stderr:
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!
    Someone could be eavesdropping on you right now (man-in-the-middle attack)!
    It is also possible that a host key has just been changed.
    The fingerprint for the ECDSA key sent by the remote host is
    SHA256:0NLL4zZubYiZ0hhSWAz/LB5VdCybIzfjZ/n0YlLLeBM.
    Please contact your system administrator.
    Add correct host key in /root/.ssh/known_hosts to get rid of this message.
    Offending ECDSA key in /root/.ssh/known_hosts:5
      remove with:
      ssh-keygen -f "/root/.ssh/known_hosts" -R "[localhost]:9010"
    ECDSA host key for [localhost]:9010 has changed and you have requested strict checking.
    Host key verification failed.
```
Just execute `ssh-keygen -f "/root/.ssh/known_hosts" -R "[localhost]:9010"`

### Chrome errors with certificate (OSX)

You can start chrome manually using
```
open -n -a /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome  --args --user-data-dir="/tmp/chrome_dev_test" --disable-web-security --ignore-certificate-errors'
```


TOSORT
## Know your 3bot secret

- From 3botconnect application go to settings, then show phrase to get your mnemonics
- Take a note of the 3bot name and your email
- When registering for the first time you can use these private words in your configurations