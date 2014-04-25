echo "Run this as sudo!"
LIST=`docker.io ps -q -a`; for ITEM in $LIST; do docker.io rm $ITEM; done
docker.io ps -a

