# Overview

We are going to use the docker link capability to run:

* postgis 9.3 with a volume mount for postgres from the host file system in one container
* django and supervisord running in another container that is linked to the postgis host


Any scripts etc. I made in this process will be available as part of my general docker git repo:

https://github.com/timlinux/docker-projects.git

# Initial run of the postgis docker image



```
docker run -name="postgis" -d -v /var/docker-data/postgres-data:/var/lib/postgresql qgis/postgis:2.1 /start.sh
createdb -h localhost -p 54322 -U docker template_postgis
```


```
timlinux@qgis2:~/docker-projects$ createuser -h localhost -p 54322 -U docker -d -E -i -l -P -r -s timlinux
Enter password for new role: 
Enter it again: 
Password: 
```


Use new user password for first two prompts and docker password for second two.


```
psql -h localhost -p 54322 template_postgis -c "CREATE EXTENSION postgis;"
psql -h localhost -p 54322 template_postgis -c "update pg_database set datistemplate=true where datname='template_postgis';"
echo "localhost:54322:*:timlinux:pumpkin" >> ~/.pgpass
chmod 0600 ~/.pgpass
```


