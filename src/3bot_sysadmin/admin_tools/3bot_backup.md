# 3Bot Backup


The 3Bot backup is a service that backs up the data of your 3Bot, with this backup you can recover your 3Bot. The first backup is made when you initialize your hosted 3Bot.

## Backing up

The backup service has 2 options:
- Marketplace
- Minio

### Marketplace backup

The marketplace backup is a service that is installed by default when you initialize a hosted 3Bot. It takes a snapshot of your data the moment your hosted 3Bot is live. If you want you can select to make automatic backups that occur every 24hours.

![Backup](./img/3bot_marketplace_backup.png)

### Minio backup

The minio backup is a service that is not installed by default. For it to make backups of your 3Bot, you need to run your own instance of minio.

> Follow this detailed guide to deploy an instance of [minio](../chatflows/solutions/storage/solution_storage.md)

If you wish to run minio backups you can enable it by clicking on __Minio__ -> __Init Now__.

Following is required to make minio backups:

- Minio url
- Access key
- Secret key
- Password 


## Recovering with marketplace backup

For a backup to be recovered you need to have:
- The 3Bot name
- The password associated with it.

If you wish to recover your 3Bot you can use following deployers:

- For __Mainnet hosted 3Bot__ Go to [3Bot Deployer Website](https://deploy3bot.grid.tf)
- For __Testnet hosted 3Bot__ Go to [3Bot Deployer Website For Testnet](https://deploy3bot.testnet.grid.tf)

Select __Deploy a new 3Bot__ -> __Recover__

Follow the steps in the chatflow and you should be able to recover your 3Bot.

## Recovering with minio backup

TODO
