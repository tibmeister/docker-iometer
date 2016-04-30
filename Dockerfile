FROM ubuntu:14.04
MAINTAINER tibmeister
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y wget libaio1 libaio-dev
RUN wget -O /download http://sourceforge.net/projects/iometer/files/iometer-stable/1.1.0/iometer-1.1.0-linux.x86_64-bin.tar.bz2
RUN tar -xvjf /download
RUN mkdir /localdata
VOLUME /localdata
