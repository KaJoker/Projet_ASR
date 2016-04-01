<<<<<<< HEAD
#! /bin/bash   # shabang line

service mysql stop    # halt mysql service
service apache2 stop  # halt apache2 service

source $1   # récuperer les paramétres à partir de prmeier argument passé

#*********************** Apache2 User change **************************#

sed -i 's/export APACHE_RUN_USER=www-data/export APACHE_RUN_USER='$APACHE_USER'/g' /etc/apache2/envvars
sed -i 's/export APACHE_RUN_GROUP=www-data/export APACHE_RUN_GROUP='$APACHE_USER'/g' /etc/apache2/envvars

useradd $APACHE_USER  # Ajout d'un utilisateur

# on change le propriétaire de ces fichiers de www-data à carl

chown -R $APACHE_USER /usr/sbin/apache2
chown -R $APACHE_USER /run/lock/apache2
chown -R $APACHE_USER /var/lib/phpmyadmin/tmp
chown -R $APACHE_USER /var/cache/tcpdf
chown -R $APACHE_USER /var/cache/apache2/mod_cache_disk

service apache2 start

#************************** Mysql User change *************************#
useradd $MYSQL_USER

sed -i 's/= mysql/= '$MYSQL_USER'/g' /etc/mysql/my.cnf

chown -R $MYSQL_USER /var/lib/mysql
chown -R $MYSQL_USER /var/run/mysqld

service mysql start

#******************* Les PID de : MySQL et Apache2 ********************#

pid_mysql=$(ps -aux | grep -w beth | cut -d"?" -f 1 | awk '{print $2}' | sed -n '1p')
pid_apache=$(ps -aux | grep -w carl | cut -d"?" -f 1 | awk '{print $2}' | sed -n '1p')

AP_USER=$(grep -i APACHE_RUN_USER= /etc/apache2/envvars | cut -d"=" -f 2 )
MY_USER=$(grep -i "user\s" /etc/mysql/my.cnf | cut -d"=" -f 2 | awk '{print $1}' | head -n 1 )


echo "APACHE_USER: $AP_USER | APACHE_PID : $pid_apache"
echo "MYSQL_USER : $MY_USER | MYSQL_PID : $pid_mysql"








=======
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
>>>>>>> 6e88ad2d8abc87d144f532d4d31f10488421ccc6
