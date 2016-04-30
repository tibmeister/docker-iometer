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
Please note that the command uses a --net host parameter to directly bind the container to the host's nework card. You need to do this because dynamo selects a random port to listen for messages from iometer. If it uses a fixed port, we could have used -p switch to map the specific port.

For dynamo and iometer to connect to each other, you need port 1006 (that iomemter listens to) and the random port picked by dynamo to be open. The easiest way is to close firewalls on both sides.

## Run the test
In iomemter, define a new Access Specification with Transfer Request Size to be 8K, or multiples of 8K. This is to avoid a section size mismatch error.

Also in iometer, define Maximum Disk Size on the Disk Targets tab. This is to avoid host disk being filled up by test data. If you are using a separate data volume, you can skip this step.
Set up other parts of the test profile and launch the test.
