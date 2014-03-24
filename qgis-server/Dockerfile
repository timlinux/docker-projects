#--------- Generic stuff all our Dockerfiles should start with so we get caching ------------
FROM ubuntu:12.04
MAINTAINER Tim Sutton<tim@linfiniti.com>

RUN  export DEBIAN_FRONTEND=noninteractive
ENV  DEBIAN_FRONTEND noninteractive
RUN  dpkg-divert --local --rename --add /sbin/initctl
#RUN  ln -s /bin/true /sbin/initctl

RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get -y update
RUN apt-get -y install ca-certificates socat openssh-server supervisor
RUN mkdir /var/run/sshd
ADD sshd.conf /etc/supervisor/conf.d/sshd.conf


#-------------Application Specific Stuff ----------------------------------------------------

RUN apt-get install -y python-software-properties
RUN add-apt-repository ppa:ubuntugis/ubuntugis-unstable
RUN apt-get update
RUN apt-get install -y qgis-mapserver


RUN echo 'root:qgis-server' | chpasswd

EXPOSE 22
EXPOSE 80

# Run any additional tasks here that are too tedious to put in
# this dockerfile directly.
ADD setup.sh /setup.sh
RUN chmod 0755 /setup.sh
RUN /setup.sh

# We will run any commands in this when the container starts
ADD start.sh /start.sh
RUN chmod 0755 /start.sh

CMD /start.sh

