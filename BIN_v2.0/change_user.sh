#! /bin/bash

sudo service mysql stop 
sudo service apache2 stop

source $1

sudo sed -i  's/export APACHE_RUN_USER=www-data/export APACHE_RUN_USER=$user_carl/g' /etc/apache2/envvars 
sudo sed -i  's/export APACHE_RUN_GROUP=www-data/export APACHE_RUN_GROUP=$user_carl/g' /etc/apache2/envvars 

bash qusetion3.sh

sudo find / -user mysql
useradd $user_bet 

AP_USER=$(sudo chown -R $user_beth /var/lib/mysql)
AP_USER=$(sudo chown -R $user_bethbeth /run/mysqld)
 
useradd $user_carl
		
AP_USER=$(sudo chown $user_carl /usr/sbin/apach2)
AP_USER=$(sudo chown $user_carl /run/lock/apache2)
AP_USER=$(sudo chown $user_carl /var/lib/phpmyadmin/tmp)
AP_USER(sudo chown $user_carl /proc/22045/task)

service mysql start
service apache2 start

ps -aux | grep mysql
ps -aux | grep apache2