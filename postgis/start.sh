#!/bin/bash

DATADIR="/var/lib/postgresql/9.3/main"
CONF="/etc/postgresql/9.3/main/postgresql.conf"
POSTGRES="/usr/lib/postgresql/9.3/bin/postgres"
INITDB="/usr/lib/postgresql/9.3/bin/initdb"

# test if DATADIR is existent
if [ ! -d $DATADIR ]; then
  echo "Creating Postgres data at $DATADIR"
  mkdir -p $DATADIR
fi

# Note that $USERNAME and $PASS below are passed via docker run e.g.
#docker run -cidfile=/home/timlinux/postgis-current-container.id -name=postgis -e USERNAME=qgis -e PASS=qgis -d -v /var/docker-data/postgres-dat:/var/lib/postgresql -t qgis/postgis:6 /start.sh


# test if DATADIR has content
if [ ! "$(ls -A $DATADIR)" ]; then
  echo "Initializing Postgres Database at $DATADIR"
  chown -R postgres $DATADIR
  su postgres sh -c "$INITDB $DATADIR"
  su postgres sh -c "$POSTGRES --single -D $DATADIR -c config_file=$CONF" <<< "CREATE USER $USERNAME WITH SUPERUSER PASSWORD '$PASS';"
fi

trap "echo \"Sending SIGTERM to postgres\"; killall -s SIGTERM postgres" SIGTERM

su postgres sh -c "$POSTGRES -D $DATADIR -c config_file=$CONF" &

# Note the dockerfile must have put the postgis.sql and spatialrefsys.sql scripts into /root/
su postgres sh -c "createdb template_postgis"
su postgres sh -c "psql template1 -c 'UPDATE pg_database SET datistemplate = TRUE WHERE datname = \'template_postgis\';'"
su postgres sh -c "psql template_postgis -f /root/postgis.sql"
su postgres sh -c "psql template_postgis -f /root/spatial_ref_sys.sql"
su postgres sh -c "psql template1 -c 'GRANT ALL ON geometry_columns TO PUBLIC;'"
su postgres sh -c "psql template1 -c 'GRANT ALL ON geography_columns TO PUBLIC;'"
su postgres sh -c "psql template1 -c 'GRANT ALL ON spatial_ref_sys TO PUBLIC;'"


wait $!
