#-------------- root user tasks ----------------------
FROM ubuntu:12.04
RUN  export DEBIAN_FRONTEND=noninteractive
ENV  DEBIAN_FRONTEND noninteractive
RUN  dpkg-divert --local --rename --add /sbin/initctl
RUN  ln -s /bin/true /sbin/initctl
RUN apt-get install -y python-software-properties

RUN add-apt-repository ppa:geonode/testing
RUN apt-get update
RUN apt-get -y install geonode
RUN geonode-updateip 127.0.0.1
# todo : figure out how to script creation of django superuser
RUN apt-get -y install supervisor
RUN apt-get -y install pwgen

#-------------- root user tasks ----------------------
ADD supervisord-geonode.conf /etc/supervisor/conf.d/
RUN adduser --home=/home/web --gecos 'user_map' web
EXPOSE 8083:80

# Run via supervisord
CMD supervisord -n

