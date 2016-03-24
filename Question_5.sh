#! /bin/bash  

service mysql stop 
service apache2 stop

sed -i  's/export APACHE_RUN_USER=www-data/export APACHE_RUN_USER=carl/g' /etc/apache2/envvars #remplacer l'utilisateur www-data par "carl" !!
sed -i  's/export APACHE_RUN_USER=www-data/export APACHE_RUN_GROUP=carl/g' /etc/apache2/envvars # remplacer le groupe www-data par "carl" !!

echo -e "500" > /var/run/apache2/apache2$SUFFIX.pid # on attribue le pid "500" à apache2 
sed -i 's/= mysql/= beth/g' /etc/mysql/my.cnf # on remplace l'utilisateur mysql par "beth" !!! 
echo -e "501" > /var/run/mysqld/mysqld.pid # on attribue le pid "501" à mysql 

service mysql start 
service apache2 start

# Apprendre pour mieux comprendre :) 
