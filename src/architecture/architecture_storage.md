![](./img/storage_architecture_0.png)

## TFGrid Backend Storage architecture

Imagine a storage system with the following benefits

- 10x more efficient (power and usage of hardware)
- ultra reliable, data can not be lost
- ultra safe & private
- ultra scalable
- sovereign, data is close to you in the country of your choice
- true peer2peer, by everyone for everyone

> This is not a dream but does exist and is the underpinning of the TFGrid.

Our storage architecture follows the true peer-to-peer design of the TF grid. Any participating node only stores small incomplete parts of objects (files, photos, movies, databases...) by offering a slice of the present (local) storage devices. Managing the storage and retrieval of all of these distributed fragments is done by a software that creates development or end-user interfaces for this storage algorithm. We call this '__dispersed storage__'.

Peer2peer provides the unique proposition of selecting storage providers that match your application and service of business criteria. For example, you might be looking to store data for your application in a certain geographic area (for governance and compliance) reasons. Also, you might want to use different "storage policies" for different types of data. Examples are live versus archived data. All of these uses cases are possible with this storage architecture and could be built by using the same building blocks produced by farmers and consumed by developers or end-users.

### Dispersed Storage Architecture Design Philosophy

Imagine we want a storage system which allows for 4 nodes (locations) out of the TFGrid to go offline and the data still need to be available and intact.

#### Classic Storage

Classic Storage designs reliability around (multiple) copies of the same data. 

To achieve the ability to loose 4 nodes, we will need 5 copies, this means 400% overhead and 5x the bandwidth to make the copies. This is not efficient. For certain blockchain workloads there can be more than 100 copies.

![](./img/classic_storage.png) 

#### ThreeFold Space Algorithm (Dispersed Storage)

Today we produce more data than ever before, we need more efficient algorithms who are more scalabe, safe and efficient.

The storage system we invented is using ideas which were used in space, when sending information from earth to the moon you don't want a re-transmit to happend if some corruption happened while sending. To resolve this "forward looking error correcting codes" have been invented. We liked this idea so much we started creating storage systems using the same idea, we started doing this more than 10 years ago.

Our algoritm does not not replicate parts of an object (file, photo, movie...) but relies on a very different algorithm which we will try to visualize as a set of equasions.

![](./img/dispersed_storage.png)

Let a,b,c,d.... be the parts of that original object. You could create endless unique equations using these parts. 

A simple example: let's assume we have 3 parts of original objects that have the following values:

```
a=1
b=2
c=3
```

(and for reference that part of real-world objects is not a simple number like `1` but a unique digital number describing the part, like the binary code for it `110101011101011101010111101110111100001010101111011.....`). With these numbers we could create endless amounts of equations:
```
1: a+b+c=6
2: c-b-a=0
3: b-c+a=0
4: 2b+a-c=2
5: 5c-b-a=12
......
```

Mathematically we only need 3 to describe the content (=value) of the fragments. But creating more adds reliability. 

Now store those equations distributed (one equation per physical storage device) and forget the original object. So we no longer have access to the values of a, b, c and see and we just remember the locations of all the equations created with the original data fragments. Mathematically we need three equations (any 3 of the total) to recover the original values for a, b or c. So do a request to retrieve 3 of the many equations and the first 3 to arrive are good enough to recalculate the original values. Three randomly retrieved equations are:

```
5c-b-a=12
b-c+a=0
2b+a-c=2
```

And this is a mathematical system we could solve:
- First: `b-c+a=0 -> b=c-a`
- Second: `2b+a-c=2 -> c=2b+a-2 -> c=2(c-a)+a-2 -> c=2c-2a+a-2 -> c=a+2`
- Third: `5c-b-a=12 -> 5(a+2)-(c-a)-a=12 -> 5a+10-(a+2)+a-a=12 -> 5a-a-2=2 -> 4a=4 -> a=1`

Now that we know `a=1` we could solve the rest `c=a+2=3` and `b=c-a=2`. And we have from 3 random equations regenerated the original fragments and could now recreate the original object. 

The redundancy and reliability in such system comes in the form of creating (more than needed) equations and storing them. As shown these equations in any random order could recreate the original fragments and therefore
redundancy comes in at a much lower overhead.

In our system 3 parts would be not enough imagine an example with 16 parts. So we have 16 original fragments for which we need 16 equations to mathematically describe them. Now let's make 20 equations and store them dispersedly on 20 devices. To recreate the original object we only need 16 equations, the first 16 that we find and collect which allows us to recover the fragment and in the end the original object. We could lose any 4 of those original 20 equations.

The likelihood of losing 4 independent, dispersed storage devices at the same time is very low. Since we have continuous monitoring of all of the stored equations, we could create additional equations immediately when one of them is missing, making it an auto-regeneration of lost data and a self-repairing storage system. The overhead in this example is 4 out of 20 which is a mere **20%** instead of (up to) **400%.**

### Why is our storage system 10x more efficient

3 reasons:

#### 1. optimized storage algorithm

The dispersed storage algorithm has a 20 times improvement in overhead, see above.

#### 2. optimized reading/writing to the underlying HD's

Thanks to the algoritm we store the information in larger blocks (typically 1 MB in size) which get stored in our low level storage database called Zero-DB.
There is only 1 Zero-DB per harddisk which allows us to control the way how we read & write to the HD, there are no multiple reader/writers at once which means we can optimize the way how the head of the hard disk has to jump over the disk platters (harddisks have spinning disks and a head is reading/wrting to it, when jumping around performance becomes bad and reliability goes down). This allows us to read/write much faster from a slow spinnging harddisk, we can use larger, cost effective and more green harddisks. This is not possible for other storage systems because the performance would become too bad.

#### 3. less context switches.

CPU's have lots of core's these days and the operating system does not know properly how to schedule your applications to use the CPU time.
The only thing it can do is to give a time slice to an application and make sure every app gets enough time. Allowing an application to use the CPU for a small time is called a "context switch", today in computers they are way too many context switches and this leads to huge inefficiencies.

Literately some computers loose 90% of their working time because of context switches.

We at ThreeFold are aware of this problem and we created our own operating system which has way less layers and also we optimize to do a lot less context switches. This leads to huge efficiency benefits/

### Available Today

Dispersed Storage is a very important building block for our TF's autonomous Grid, we store all kinds of data (blockchain databases included) by using this method. This underlying storage method will be presented in many different forms for developers and end-user protocols.

#### S3 Service

What is currently available is an __S3 interface__ based on the [min.io](https://min.io/) S3 Interface. With the dispersed storage layer available, you could build fast, robust and reliable storage and archiving solutions. 

A typical master-slave setup would look like:

![](./img/storage_architecture_1.png)






