echo "---------------------------------------------------------------------------"
echo "This will run postgresql in a docker container with persistent storage in "
echo "$HOME/docker_shared_postgres_data"
echo "See https://github.com/stigi/dockerfile-postgresql"
echo "---------------------------------------------------------------------------"
cd 
git clone https://github.com/stigi/dockerfile-postgresql.git
cd dockerfile-postgresql/
mkdir -p $HOME/docker_shared_postgres_data
docker build -t "postgresql:9.2.4" .
docker run -d -v $HOME/docker_shared_postgres_data:/var/lib/postgresql postgresql:9.2.4
