How I set up tile stream in docker:
===================================

Setup docker and run a docker instance::

    sudo apt-get install linux-image-extra-`uname -r`
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
    sudo sh -c "echo deb http://get.docker.io/ubuntu docker main \
    	>> /etc/apt/sources.list.d/docker.list"
    sudo apt-get update
    sudo apt-get install lxc-docker
    sudo docker pull ubuntu
    sudo docker run -i -p 22 -p 80 -t ubuntu:12.04 /bin/bash


Setup docker instance to run ssh::

    apt-get update
    apt-get install openssh-server
    mkdir /var/run/sshd
    /usr/sbin/sshd
    passwd

Follow the prompts to set a root password - I set mine to 'tilestream'.



From another terminal use fabgis to install tilemill::

    sudo apt-get install python-dev python-virtualenv
    mkdir tilestream-fab
    cd tilestream-fab
    virtualenv venv
    source venv/bin/activate
    pip install fabgis
    cat "from fabgis.tilemill import setup_tilemill, start_tilemill" > fabfile.py
    sudo docker ps -a | grep bash
    
Make a note of the port number that ssh runs on in your docker instance then::
    
    fab -H root@localhost:49153 setup_tilemill
    fab -H root@localhost:49153 start_tilemill
