#!/bin/bash

echo "Run this as sudo!"
# Run various inter-related docker containers for a production site.

# If you have problems connecting to the postgis container, try doing

# sudo rm -rf /var/docker-data/postgres-data/

# being aware obviously that it will DESTROY ALL YOUR DATA
# Then run the commands below

# Start postgis container, ensuring a postgres user 'qgis' with pass 'qgis' exists
docker run -cidfile="$IDFILE" -name="postgis" -e USERNAME=qgis -e PASS=qgis -d -v /var/docker-data/postgres-data:/var/lib/postgresql -t timlinux/postgis:2.1 /start.sh
# Start tilemill, linked to the postgis site so it can access it
# using details from env-vars $PG_PORT_5432_TCP_ADDR (for the ip address)
# and $PG_PORT_5432_TCP_PORT (for the port number).
docker run -d -name="tilemill" -link postgis:pg -p 2222:22 -v /home/gisdata:/home/gisdata -v /home/timlinux/Documents/MapBox:/Documents/MapBox linfiniti/tilemill supervisord -n

docker ps -a
