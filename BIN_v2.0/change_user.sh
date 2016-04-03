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

echo "500" > /var/run/apache2/apache2$SUFFIX.pid  # c'est faux 

service apache2 start 



#************************** Mysql User change *************************#
useradd $MYSQL_USER

sed -i 's/= mysql/= '$MYSQL_USER'/g' /etc/mysql/my.cnf

chown -R $MYSQL_USER /var/lib/mysql
chown -R $MYSQL_USER /var/run/mysqld

echo "501" > /var/run/mysqld/mysqld.pid # c'est faux aussi 

service mysql start

#******************* Les PID de : MySQL et Apache2 ********************#

pid_mysql=$(ps -aux | grep -w $MYSQL_USER | cut -d"?" -f 1 | awk '{print $2}' | sed -n '1p')
pid_apache=$(ps -aux | grep -w $APACHE_USER | cut -d"?" -f 1 | awk '{print $2}' | sed -n '1p')

AP_USER=$(grep -i APACHE_RUN_USER= /etc/apache2/envvars | cut -d"=" -f 2 )
MY_USER=$(grep -i "user\s" /etc/mysql/my.cnf | cut -d"=" -f 2 | awk '{print $1}' | head -n 1 )


echo "APACHE_USER: $AP_USER | APACHE_PID : $pid_apache"
echo "MYSQL_USER : $MY_USER | MYSQL_PID : $pid_mysql"

