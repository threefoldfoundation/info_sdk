## Minio deployment
Minio is an object storage server with a nice ui and S3 APIs.
This solution will help create a Minio deployment in a Single or Master/Slave mode.

## Steps

#### Choose Name
![minio_1](img/minio_1.png)

#### Setup Type
![minio_2](img/minio_2.png)

#### Choose Storage Type
![minio_3](img/minio_3.png)

#### Set Container Resources
![minio_4](img/minio_4.png)

#### Specify Number of Shards
![minio_5](img/minio_5.png)

#### Select pool you wish to distribute ZDB workloads on
![minio_6](img/minio_6.png)

#### Select pool for Primary
![minio_7](img/minio_7.png)

#### Select node for Primary. You can choose to be selected automatically
![minio_8](img/minio_8.png)

#### Choose Network
![minio_9](img/minio_9.png)

#### Set Credentials (AK/SK)
![minio_10](img/minio_10.png)

#### Optional Container Logs
![minio_11](img/minio_11.png)

#### Add you SSH Key
![minio_12](img/minio_12.png)

### Deploying your solution
![minio_13](img/minio_13.png)

#### Select IP
![minio_14](img/minio_14.png)

### Choose whether you want to assign a global Ipv6 address for your container or not
![minio_15](img/minio_15.png)

#### Confirmation
![minio_16](img/minio_16.png)

#### ZDB Reservation
The solution does two reservations, one for ZDB which will be used as backend for Minio and the next for Minio containers.
![minio_17](img/minio_17.png)

#### Success
![minio_18](img/minio_18.png)

#### Access your Solution
![minio_19](img/minio_19.png)
