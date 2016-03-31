#!/bin/bash
echo "\n--- Installation de mysql et phpmyadmin et apache2 ---\n" 
apt-get update
source $1
echo "mysql-server mysql-server/root_password password $MYSQL_PASSWD" | debconf-set-selections
echo "mysql-server mysql-server/root_password_again password $MYSQL_PASSWD"| debconf-set-selections


echo "phpmyadmin phpmyadmin/dbconfig-install boolean true" | debconf-set-selections

echo "phpmyadmin phpmyadmin/app-password password $PMA_PASS" | debconf-set-selections
echo "phpmyadmin phpmyadmin/app-password-confirm password $PMA_PASS" | debconf-set-selections

echo "phpmyadmin phpmyadmin/mysql/app-pass password $MYSQL_PASSWD" | debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/admin-pass password $MYSQL_PASSWD" | debconf-set-selections
echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect $PMA_WEBSERVER" | debconf-set-selections

#echo "dbconfig-common dbconfig-common/dbconfig-remove boolean true" | debconf-set-selections 
echo "dbconfig-common dbconfig-common/dbconfig-install boolean true" | debconf-set-selections
#echo "dbconfig-common dbconfig-common/dbconfig-reinstall boolean false" | debconf-set-selections

apt-get -y apache2
apt-get -y install mysql-server phpmyadmin curl
