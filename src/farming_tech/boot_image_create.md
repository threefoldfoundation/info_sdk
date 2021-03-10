## Create a Bootable Image

At this point you should have created your farm and noted its ID. The next step is to generate a bootable image of Zero-OS to boot your nodes.

The bootstrap service: https://bootstrap.grid.tf is there for you to generate your Zero-OS images.
In the bootstrap wizard, enter your farm ID:

![boostrap farmer ID](img/bootstap_farmid.png)

Choose you network:

If you want to run your node on Mainnet, select Production.
If you want to run your node on Testnet, select Testing.
If you want to run your node on Devnet, select Development.

> You can only generate tokens on Mainnet!

If you are not sure what to use, select Production.

![boostrap network selection](img/bootstap_network.png)

Lastly download the generated image. There are multiple formats of images available. Pick the one most appropriate for your setup (if you know what you are doing).

We going to explain here the EFI Usb method. So please click the `USB Image` button on the `EFI USB` section
![efi usb](img/efi_usb_option.png)

Once the image is download, get a free usb flash disk and prepare it as follows:

- Remove all existing partitions from the usb (it could be optional)
- Execute: `dd if=/path/to/image of=/path/to/usb conv=sync` (eg: `dd if=uefimg-prod.img of=/dev/sdb1 conv=sync`)
- Plug out the USB drive when it's done copying.


