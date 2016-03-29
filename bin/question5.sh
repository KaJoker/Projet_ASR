#! /bin/bash
service mysql stop 
#service apache2 stop
sed -i  's/export APACHE_RUN_USER=www-data/export APACHE_RUN_USER=carl/g' /etc/apache2/envvars 
sed -i  's/export APACHE_RUN_GROUP=www-data/export APACHE_RUN_GROUP=carl/g' /etc/apache2/envvars 

echo "500" > /var/run/apache2/apache2$SUFFIX.pid
sed -i 's/= mysql/= beth/g' /etc/mysql/my.cnf  
echo "501" > /var/run/mysqld/mysqld.pid

pid_sql=$(cat /var/run/mysqld/mysqld.pid) 
pid_apc=$(cat /var/run/apache2/apache2$SUFFIX.pid) 
 
AP_USER=$(grep -i APACHE_RUN_USER= /etc/apache2/envvars | cut -d"=" -f 2 )
MY_USER=$(grep -i "user\s" /etc/mysql/my.cnf | cut -d"=" -f 2 | awk '{print $1}' | head -n 1 )

echo "APACHE_USER: $AP_USER | APACHE_PID : $pid_apc"
echo "MYSQL_USER : $MY_USER | MYSQL_PID  : $pid_sql"  

service mysql start 
service apache2 start
mysql -ppassmysql
