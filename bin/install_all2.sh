#!/bin/bash
echo "Recherche de mis-à-jour"
#apt-get update
source install.conf
echo "mysql-server mysql-server/root_password password $MYSQL_PASSWD" | debconf-set-selections
echo "mysql-server mysql-server/root_password_again password $MYSQL_PASSWD"| debconf-set-selections
echo "phpmyadmin phpmyadmin/app-password password $PMA_PASS" | debconf-set-selections
echo "phpmyadmin phpmyadmin/app-password-confirm password $PMA_PASS" | debconf-set-selections
echo "phpmyadmin phpmyadmin/setup-username $PMA_APP_USER"|debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/app-pass password pass" | debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/admin-pass password pass" | debconf-set-selections
echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect none" | debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/admin-user $PMA_MYSQL_ADMIN_USER"|debconf-set-selections
echo "Installation d'apache"
apt-get -y PMA_WEBSERVER
apt-get -y install mysql-server phpmyadmin

