#-------------- root user tasks ----------------------
FROM ubuntu:12.04
VOLUME ["/home"]
RUN adduser --home=/home/web --disabled-login --gecos 'user_map' web
ADD sources.list /etc/apt/sources.list
RUN apt-get update
RUN apt-get -y install git
RUN apt-get -y install python-virtualenv 
RUN apt-get -y install python-dev build-essential
RUN pip install uwsgi
RUN apt-get -y install nginx
RUN apt-get -y install supervisor
#RUN chown -R web.web /home/web 

#-------------- web user tasks ----------------------
#USER web
WORKDIR /home/web

# We should be able to git checkout like this but it doesnt work
RUN cd /home/web/; git clone http://github.com/timlinux/user_map.git

# So doing it the old fashioned way
#RUN cd /home/web;\
#    su web -c "git clone https://github.com/timlinux/user_map.git";

WORKDIR /home/web/user_map
RUN virtualenv venv
RUN venv/bin/pip install -r requirements.txt
RUN uwsgi -s /tmp/uwsgi.sock -w users:APP -H /home/web/user_map/venv --chmod-socket=666

USER root
#-------------- root user tasks ----------------------
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
ADD nginx.default /etc/nginx/sites-enabled/default
ADD supervisord-nginx.conf /etc/supervisor/conf.d/
RUN if [ ! -f $FILE ]; then ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default; fi;
# Set the pwd or root to 'inasafe'
RUN echo "root:inasafe" | chpasswd
EXPOSE 8081:80
USER web
CMD ["/usr/bin/supervisord", "-n"] -D
