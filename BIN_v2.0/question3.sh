#! /bin/bash 

echo "rick" > /etc/hostname 
host=$(hostname)

http_state=$( sh http_state.sh )

mysql_state=$(bash sql.sh)

phpmyadmin_state=$(sh phpmyadmin.sh)

AP_USER=$(grep -i APACHE_RUN_USER= /etc/apache2/envvars | cut -d"=" -f 2 )

MY_USER=$(grep -i "user" /etc/mysql/my.cnf | cut -d"#" -f 4 | awk '{print $3}' )

pid_mysql=$(pidof -s mysql)

pid_mysql2=$(ps -aux  | grep -w mysql | cut -d"?" -f 1 | awk '{print $2}' | grep -E -w "([0-9][0-9][0-9])")

pid_http=$(pidof -s apache2 | awk '{print $1}' ) 

echo 'hostname :' $host >information.txt 
echo 'http_state :' $http_state >>information.txt
echo 'Mysql_state :' $mysql_state >>information.txt
echo 'phpmyadmin_state :'$phpmyadmin_state  >>information.txt
echo 'http_user_conf :' $AP_USER >>information.txt
echo 'Mysql_user_conf :' $MY_USER >>information.txt
echo 'http_user_pid :'  $pid_http >>information.txt
echo 'mysql_user_pid :' $pid_mysql >>information.txt
