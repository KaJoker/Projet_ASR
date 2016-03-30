#! /bin/bash 

echo "\n--- Installation de mysql et phpmyadmin et apache2 ---\n" 
echo "Recherche de mis-à-jour" 
#apt-get	update  
echo "mysql-server mysql-server/root_password password glenn" | debconf-set-selections
echo "mysql-server mysql-server/root_password_again password glenn" | debconf-set-selections
echo "phpmyadmin phpmyadmin/dbconfig-install boolean true" | debconf-set-selections
echo "phpmyadmin phpmyadmin/app-password password maggie" | debconf-set-selections
echo "phpmyadmin phpmyadmin/app-password-confirm password maggie" | debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/admin-pass password glenn" | debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/app-pass password glenn" | debconf-set-selections
echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect none" | debconf-set-selections
apt-get -y install phpmyadmin mysql-server 
apt-get -y install curl > /dev/null 2>&1 
