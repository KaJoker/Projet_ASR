#!/bin/bash

source usr/local/bin/installer.conf

echo "\n--- Installation of mysql and Phpmyadmin with quiet mode ---\n"

apt-get update

echo "mysql-server mysql-server/root_password $MYSQL_PASSWD" | debconf-set-selections
echo "mysql-server mysql-server/root_password_again password $MYSQL_PASSWD" |  debconf-set-selections
echo "phpmyadmin phpmyadmin/dbconfig-install boolean true" | debconf-set-selections
echo "phpmyadmin phpmyadmin/app-password password passphp" | debconf-set-selections
echo "phpmyadmin phpmyadmin/app-password-confirm password passphp" | debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/admin-pass password passphp" | debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/app-pass password passphp" | debconf-set-selections
echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect $PMA_WEBSERVER" | debconf-set-selections

apt-get -y install phpmyadmin
