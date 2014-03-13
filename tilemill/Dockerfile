#--------- Generic stuff all our Dockerfiles should start with so we get caching ------------
FROM ubuntu:12.04
MAINTAINER Tim Sutton<tim@linfiniti.com>

RUN  export DEBIAN_FRONTEND=noninteractive
ENV  DEBIAN_FRONTEND noninteractive
RUN  dpkg-divert --local --rename --add /sbin/initctl
RUN  ln -s /bin/true /sbin/initctl

RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get -y update 
RUN apt-get -y install ca-certificates socat openssh-server supervisor
RUN mkdir /var/run/sshd
ADD sshd.conf /etc/supervisor/conf.d/sshd.conf


#-------------Application Specific Stuff ----------------------------------------------------

RUN apt-get install -y python-software-properties
RUN add-apt-repository ppa:developmentseed/mapbox
RUN apt-get update
RUN apt-get install -y tilemill socat

ADD tilemill.conf /etc/supervisor/conf.d/tilemill.conf
# socat is used to proxy linked container's 5432 to 
# make it appear as if it is locally running on 5432
ADD socat.conf /etc/supervisor/conf.d/socat.conf

RUN echo 'root:tilestream' |chpasswd

EXPOSE 22
EXPOSE 20008
EXPOSE 20009

# Run any additional tasks here that are too tedious to put in
# this dockerfile directly.
ADD setup.sh /setup.sh
RUN chmod 0755 /setup.sh
RUN /setup.sh

# We will run any commands in this when the container starts
ADD start.sh /start.sh
RUN chmod 0755 /start.sh

CMD /start.sh

