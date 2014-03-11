#!/bin/bash

echo "This will KILL all your production containers and any?"
echo "data stored in them. Are you sure you want to do this"
echo "Data mounted in volumes will not be affected."
read -sn 1 -p "Press any key to continue..."
echo

docker kill tilemill
docker rm tilemill
docker kill postgis
docker rm postgis

sudo docker ps -a

