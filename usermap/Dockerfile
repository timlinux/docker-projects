#-------------- root user tasks ----------------------
FROM ubuntu:12.04
RUN  export DEBIAN_FRONTEND=noninteractive
ENV  DEBIAN_FRONTEND noninteractive
RUN  dpkg-divert --local --rename --add /sbin/initctl
RUN  ln -s /bin/true /sbin/initctl
#RUN adduser --home=/home/web --disabled-login --gecos 'user_map' web
RUN adduser --home=/home/web --gecos 'user_map' web
ADD sources.list /etc/apt/sources.list
RUN apt-get update
RUN apt-get -y install git
RUN apt-get -y install python-virtualenv 
RUN apt-get -y install python-dev build-essential
RUN pip install uwsgi
RUN apt-get -y install nginx
RUN apt-get -y install supervisor

#-------------- web user tasks ----------------------
#USER web
#WORKDIR /home/web
#RUN chown -R web.web /home/web 

USER root
#-------------- root user tasks ----------------------
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
ADD nginx.default /etc/nginx/sites-enabled/default
ADD supervisord-nginx.conf /etc/supervisor/conf.d/
RUN if [ ! -f $FILE ]; then ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default; fi;
# Set the pwd or root to 'inasafe'
RUN echo "root:inasafe" | chpasswd
ADD post-setup.sh /home/web/
RUN /home/web/post-setup.sh
RUN apt-get -y purge build-essential
RUN apt-get -y autoremove
EXPOSE 8082:80
#USER web
# Run manually
#RUN uwsgi -s /tmp/uwsgi.sock -w users:APP -H /home/web/user_map/venv --chmod-socket=666
# Run via supervisord
CMD ["/usr/bin/supervisord", "-n"] -D
