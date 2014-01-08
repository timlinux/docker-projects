#!/bin/bash
OWNCLOUD=$(docker run -d -h "owncloud.linfiniti.com" linfiniti/owncloud)
docker logs $OWNCLOUD
