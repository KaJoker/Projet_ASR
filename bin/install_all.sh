#! /bin/bash 

echo "\n--- Installation de mysql et phpmyadmin ---\n" 
echo "Recherche de mis-à-jour" 
apt-get	update  
echo "mysql-server mysql-server/root_password password passmysql" | debconf-set-selections
echo "mysql-server mysql-server/root_password_again password passmysql" | debconf-set-selections
echo "phpmyadmin phpmyadmin/dbconfig-install boolean true" | debconf-set-selections
echo "phpmyadmin phpmyadmin/app-password password passphp" | debconf-set-selections
echo "phpmyadmin phpmyadmin/app-password-confirm password passphp" | debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/admin-pass password passphp" | debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/app-pass password passphp" | debconf-set-selections
echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect none" | debconf-set-selections
apt-get -y install phpmyadmin mysql-server 
echo -e "\n--- Installation de curl ---\n"
apt-get -y install curl > /dev/null 2>&1 
