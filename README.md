# Docker-IOMeter

## Building Docker-IOMeter
1. Clone this repository
2. Run the following command to build it:
```bash
docker build -t iometer .
```
## Launch iometer and dynamo
1. Launch iometer on the remote machine.
2. Launch the container on the Linux machine:
```bash
docker run -it -h mycontainer --net host --rm iometer /dynamo -i {remote IOMeter host} -m $HOSTNAME
```
> Please note that the command uses a --net host parameter to directly bind the container to the host's nework card. You need to do this because dynamo selects a random port to listen for messages from iometer. If it uses a fixed 
port, we could have used -p switch to map the specific port.

For dynamo and IOMeter to connect to each other, you need port 1006 (that IOMeter listens to) and the random port picked by dynamo to be open. The easiest way is to shutdown firewalls on both sides.

## Run the test
In IOMeter, define a new Access Specification with the following settings:

In IOmeter, define Maximum Disk Size on the Disk Targets tab. This is to avoid host disk being filled up by test data. If you are using a separate data volume that is of the correct size, you can skip this step.
Rule of thumb for disk size: one sector is 512 B, so 

|Sectors|Approx File Size |
|:-----:|:---------------:|
|204800|~100MB|
|1048576|~512MB|
|524288|~256MB|

Set up other parts of the test profile and launch the test such as:
*Disk Targets Tab
|Setting|Value|
|:-----:|:---:|
|Outstanding I/Os|32|
|Write IO Data Pattern|Pseudo random|

*Define a new Access Specification
|Setting|Value|
|:-----:|:---:|
|Transfer Req Size|4k (or multiples thereof)|
|Read/Write|40/60|
|Random/Sequential|30/70|

*Test Setup
|Setting|Value|
|:-----:|:---:|
|Run Time|10 Minutes (minimum)|

## Some other items for consideration
If you are behind a proxy, modify the 01proxy file and fill in the information.  This will allow Aptitude to traverse your proxy

If you are wanting to test a mounted filesystem, create a file of the desired size, format it, then mount it as /data into the container at runtime as follows:

```bash
fallocate -l 512M test
docker run -it -h mycontainer --net host -v ./test:/data --rm iometer /dynamo -i {remote IOMeter host} -m $HOSTNAME
```

> Notice the *-v* switch, this is the volume switch in the format of <host directory/file>:<directory in container>.  The Dockerfile already has the /data directory created, so just pass the argument here and you're golden.  
Don't pass anything, no problem! /data in the container will just be another folder out there.

