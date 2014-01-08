#!/bin/bash
/usr/bin/mysqld_safe &
sleep 5
/usr/bin/mysql -u root -pfar324ben -e "CREATE DATABASE owncloud; GRANT ALL ON owncloud.* TO 'owncloud'@'localhost' IDENTIFIED BY 'fan678bresk';"
