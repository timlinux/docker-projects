# Dockerfile PostGIS

Run interactively:

```
sudo docker.io run --name "postgis" -p 2222:22 -p 25432:5432 -i -t kartoza/postgis:2.1 /bin/bash
```

Run as daemon (more typical):

```
sudo docker.io run --name "postgis" -p 2222:22 -p 25432:5432 -d -t kartoza/postgis:2.1 /start.sh
```

Connect with psql:


psql -h localhost -U docker -p 25432 -l





## Persistance

You can mount the database directory as a volume to persist your data:

`docker run -d -v $HOME/postgres_data:/var/lib/postgresql postgis:2.1`

Makes sure first need to create source folder: `mkdir -p ~HOME/postgres_data`.

If you copy existing postgresql data, you need to set permission properly (chown/chgrp)

