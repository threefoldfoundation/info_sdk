# 3Bot Wallets

<!-- <img src="img/3bot_wallet.png" width="300" alt=""> -->

Your 3Bot comes in handy with a built-in __Stellar wallets__, listing all your existing Stellar wallets, with the option to create a new wallet or import an existing one. This feature was especially made with the aim to make it easier and faster for you to reserve and pay for your IT Capacity. 

Please keep in mind that testnet and mainnet operate with tokens that reside on another network, the testnet and mainnet of the Stellar network resp. 
A testnet wallet can only send and receive transactions within the test network, the same way with how a mainnet wallet could only send and receive transactions within the main network.

## Creating a New Wallet

Can be created from the create button in Wallets page

## Import an Existing Wallet 

Using your stellar secret you saved from an existing wallet you can import your wallet into the 3Bot.
The Stellar secret is a string of characters, starting with a 'S' (unlike the public address which starts with a 'G').

## Viewing Your Existing Wallet

Simply click on one of your existing wallet see the details of the wallet.

![](./img/3bot_wallet_detail.png)

### Your Wallet Details

- Name: is the name that you give to the wallet, and how it is shown in the admin panel
- Network: the stellar network (as the wallet can target the mainnet or testnet, which host also tokens that only work for the relevant network) 
- [Trustlines](https://www.stellar.org/developers/guides/concepts/assets.html) are specific to the Stellar network to indicate that a user is 'trusting' the asset / crypto issuer, in our case trusting  ThreeFold Foundation as issuer of TFT, TFTA, FreeTFT. 
Trustlines are specific to the network, so it needs to be established both on testnet and mainnet, and for all the tokens that someone intends to hold. Without a trustline, a wallet address can't be fed with tokens. 
In order to make it easier for the user, trustlines are being established automatically when creating a wallet for TFT, TFTA and FreeTFT in the admin panel as well as in 3Bot connect app. However, if you use a third party Stellar wallet for your tokens, you need to create it yourself. 




