echo "Run this as sudo!"
LIST=`docker ps -q -a`; for ITEM in $LIST; do docker rm $ITEM; done
docker ps -a

