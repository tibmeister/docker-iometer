FROM ubuntu
MAINTAINER tibmeister
RUN apt-get update
RUN apt-get install -y wget libaio1 libaio-dev
RUN wget http://sourceforge.net/projects/iomemter/files/iometer-stable/1.1.0/iometer-1.1.0-linux.x86_64-bin.tar.bz2/download
RUN tar -xvjf download
RUN mkdir /localdata
VOLUME /localdata
