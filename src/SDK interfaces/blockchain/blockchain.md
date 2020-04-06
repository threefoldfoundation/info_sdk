# blockchain SDK

<!--

TODO Look for content about the low level json / toml files
TODO Create some description around these toml/json files

-->
## Introduction

The peer2peer grid works with the "smart contract for IT" architecture.  An overview of that architecture is here:

![smart contract for IT](img/smart_contract_fot_IT.png)

In this architectre the nodes that make up the ThreeFold grid "discover" that they have to do (launch a container, stop a container, create a k3S node, create a private overlay network) by querying the blockchain database and look for any updated records to execute on. The actual data stored in the blockchain database (BCDB) is structured and contains all information needed to get the intended tasks executed.

