#!/bin/bash
IDFILE=/home/timlinux/postgis-current-container.id
docker run -cidfile="$IDFILE" -name="postgis" -d -v /var/docker-data/postgres-data:/var/lib/postgresql -t qgis/postgis:1 /start.sh
