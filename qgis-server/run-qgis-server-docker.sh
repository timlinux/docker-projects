#!/bin/bash
#
# Deploy the qgis-server container
#
if [ $# -ne 2 ]; then
    echo "Deploy the qgis-server container."
    echo "Usage:"
    echo "$0 <version> <data_dir>"
    echo "e.g.:"
    echo "$0 1.0 /home/gisdata"
    echo "Will run the container using tag version 1.0 and make "
    echo "/home/gisdata available as /home/gisdata inside the container"
    echo "Once it is running see the commit-and-deploy.sh script if you"
    echo "wish to save new snapshots."
    exit 1
fi

set +x
docker run -t -d --name="qgis-server" -p 2224:22 -p 8884:80 -v $2:/home/gisdata timlinux/qgis-server:1.0 supervisord -n
