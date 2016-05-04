FROM ubuntu:14.04

MAINTAINER tibmeister

ENV DEBIAN_FRONTEND=noninteractive

ADD ["/01proxy","/etc/apt/apt.conf.d/01proxy"]

RUN ["apt-get","update"]
RUN ["apt-get","install","-y","wget","libaio1","libaio-dev"]
RUN ["apt-get","autoremove","-y"]
RUN ["apt-get","autoclean","all"]

ADD ["/dynamo","/dynamo"]

RUN ["mkdir","/localdata"]
RUN ["mkdir","/data"]

VOLUME ["/localdata"]

LABEL version="1.0"
LABEL description "To run try this \
docker run -it -h mycontainer --net host --rm iometer /dynamo -i {remote IOMeter host} -m $HOSTNAME"
