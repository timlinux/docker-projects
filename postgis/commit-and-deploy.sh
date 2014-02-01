!/bin/bash
# Commit and redeploy the user map container
# 
if [ $# -ne 1 ]; then
    echo "Commit and then redeploy the user_map container."
    echo "Usage:"
    echo "$0 <version>"
    echo "e.g.:"
    echo "$0 1.6"
    echo "Will commit the current state of the container as version 1.6"
    echo "and then redeploy it."
    exit 1
fi
VERSION=$1
IDFILE=/home/timlinux/postgis-current-container.id
ID=`cat $IDFILE`
docker commit $ID timlinux/postgis:$VERSION -run='{"Cmd": ["/start.sh"], "PortSpecs": ["80"], "Hostname": "postgis"}' -author="Tim Sutton <tim@linfiniti.com>"
docker kill $ID
rm $IDFILE
docker run -cidfile="$IDFILE" -d -p 8099:80 -p 2099:22 -t timlinux/postgis:$VERSION supervisord -n
docker run -cidfile="$IDFILE" -name="postgis" -d -v /var/docker-data/postgres-data:/var/lib/postgresql -t timlinux/postgis:$VERSION
NEWID=`cat $IDFILE`
echo "Postgis has been committed as $1 and redeployed as $NEWID"
docker ps -a | grep $NEWID

