echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
apt-get update
apt-get install -y openssh-server supervisor pwgen

mkdir /var/run/sshd

echo "[program:sshd]" > /etc/supervisor/conf.d/sshd.conf
echo "user=root" >> /etc/supervisor/conf.d/sshd.conf
echo "command=/usr/sbin/sshd -D" >> /etc/supervisor/conf.d/sshd.conf
echo "autorestart=true" >> /etc/supervisor/conf.d/sshd.conf
echo "stopsignal=INT" >> /etc/supervisor/conf.d/sshd.conf

echo "[program:tilemill]" >> /etc/supervisor/conf.d/tilemill.conf
echo "user=root" >> /etc/supervisor/conf.d/tilemill.conf
echo "command=/usr/bin/nodejs /usr/share/tilemill/index.js --server=true" >> /etc/supervisor/conf.d/tilemill.conf
echo "autorestart=true" >> /etc/supervisor/conf.d/tilemill.conf
echo "stopsignal=INT" >> /etc/supervisor/conf.d/tilemill.conf

passwd
