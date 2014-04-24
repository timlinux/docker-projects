I assume you have docker installed already (the build file and example below
refers to docker.io instead of docker for commands since that is how it is
packaged in Ubuntu 14.04). So all instructions below are based on 14.04 as the
host:

```bash
sudo apt-get install docker.io
sudo apt-get install apt-cacher-ng
git clone git@github.com:timlinux/docker-projects.git
cd docker-projects/geogit
```

Edit ``71-apt-cacher-ng`` to use your host's ip address.

```bash
sudo ./build.sh
```

Its going to take a long time (and consume a chunk of bandwidth) for the build
because you have any docker base operating system images on your system and the
maven build grabs a lot of jars.

After it is installed run a container:

```bash
sudo docker.io run --name="geogit" -p 38080:8080 -d -t kartoza/geogit /start.sh
```


Then from your local machine you should be able to clone the GeoGitRepo
repository that is created in the docker container:

```
geogit clone http://localhost:38080/GeoGitRepo/ gisdata-repo-clone
```


- Tim Sutton, April 2014
