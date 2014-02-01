#!/bin/bash
docker run -name="postgis" -d -v /var/docker-data/postgres-data:/var/lib/postgresql timlinux/postgis /start.sh
