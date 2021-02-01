# Manage Storage Nodes

Storage Nodes contain the disk storage (HDD and SSD) capacity that can be used for your workloads. 

Data are stored in Zero-DB's. I

Zero-DB (ZDB) is a very fast and efficient key-value store redis-protocol (mostly) compatible, which makes data persistent inside an always append datafile, with namespaces support.

Update of storage is done in an automated way in your VDC. 
The rule applied for this is the following: ZDBs grow based on the usage, once you reach 70% of your plan it will reserve more storage capacity to a degree where usage is reset 30% after the extension. 

The button `ZDBS INFO` has all of the infos of ZDBs set up for your needs. 

It contains meta-information about the stored data in the following format: 

![](./img/evdc-k8s-storage-zdb.png)
