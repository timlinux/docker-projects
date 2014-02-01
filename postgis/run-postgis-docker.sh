#!/bin/bash
#docker run -name="postgis" -p 2222:22 -p 54322:5432 -d qgis/postgis:2.1-2 /start.sh
docker run -name="postgis" -p 54322:5432 -d -v /var/docker-data/postgres-data:/var/lib/postgresql qgis/postgis:2.1-4 /start.sh
#docker run -name="postgis" -d -v /var/docker-data/postgres-data:/var/lib/postgresql helmi03/docker-postgis
