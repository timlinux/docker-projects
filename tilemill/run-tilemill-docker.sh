#!/bin/bash
# 
# Deploy the tilemill container
#
if [ $# -ne 1 ]; then
    echo "Deploy the tilemill container."
    echo "Usage:"
    echo "$0 <version>"
    echo "e.g.:"
    echo "$0 1.0"
    echo "Will run the container using tag version 1.0"
    echo "Once it is running see the commit-and-deploy.sh script if you"
    echo "wish to save new snapshots."
    exit 1
fi

HOST_DATA_DIR=/home/gisdata
if [ ! -d $HOST_DATA_DIR ]
then
    mkdir $HOST_DATA_DIR
fi

HOST_MAPBOX_DIR=/home/timlinux/Documents/MapBox
if [ ! -d $HOST_MAPBOX_DIR ]
then
    mkdir $HOST_MAPBOX_DIR
fi

set -x
docker run -t -d --name="tilemill" -link postgis:pg -p 2222:22 -v $HOST_DATA_DIR:/home/gisdata -v $HOST_MAPBOX_DIR:/Documents/MapBox timlinux/tilemill:$1 supervisord -n
