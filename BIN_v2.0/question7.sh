#! /bin/bash

# 1) modification dd hostname ******************************************************************
source $1

hostname="rick"
hostname2=$(cat /etc/hostname)
if [ $hostname = $hostname2 ]
        then
                echo "hostname : " $hostname2 > auto7.txt      
                 
           # donc on a pas besoin de
    # de faire une opération d'écriture sur le fichier
        else

                echo "rick" > /etc/hostname
                echo "127.0.1.1 rick" > /etc/hosts # un plus pôur le DNS c'est pas obligatoire
                echo "hostname : " $hostname2 > auto7.txt
fi

# 2) L'état de HTTP **************************************************************************** 

# Si mysql-server et/ou phpmyadmin sont installés alors on les supprimes car on sait pas leur 
# configuration 

echo  "phpmyadmin phpmyadmin/dbconfig-remove boolean true" |debconf-set-selections
echo  "dbconfig-common  dbconfig-common/dbconfig-remove  boolean true" | debconf-set-selections
echo  "mysql-server-5.5 mysql-server-5.5/postrm_remove_databases   boolean true"| debconf-set-selections
echo  "dbconfig-common dbconfig-common/pgsql/changeconf boolean false" | debconf-set-selections
echo  "dbconfig-common dbconfig-common/dbconfig-remove boolean true" |debconf-set-selections
echo  "dbconfig-common dbconfig-common/remove-error select abort" |debconf-set-selections

apt-get -y remove  mysql-server mysql-client mysql-common phpmyadmin apache2
apt-get -y purge   mysql-server mysql-client mysql-common phpmyadmin apache2
 
apt-get update 

#**************************** Installation de mysql server et apache et phpmyadmin *********

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

# on teste le HTTP server ************************************************************************* 

michon="michonne" # variable
echo "michonne" > /var/www/html/ping_me # On écrit le mot "michonne" sur le fichier ping_me
IP=$(ifconfig eth0 | grep 'inet adr:' | cut -d: -f 2 | awk '{print $1}') # On récupere l'IP de l'hôte
#echo $IP  # verfication de l'IP
verif=$(curl -s http://$IP/ping_me) # verif récupere le contenu de la page ping_me
if [ "$verif" = "$michon" ]      # on verfie que le contenu de la variable michon = contenu de la variable verif
            then echo "http_state : OK" >> auto7.txt 
            else echo "http_state : KO" >> auto7.txt 
fi

# On teste MYSQL 

(echo "show databases;" | mysql -uroot -pglenn) 2>/dev/null 1>/dev/null
ret=$(echo $?)
zero=0
if [ "$ret" -eq "$zero" ] 
      then echo "mysql_state : OK" >> auto7.txt 
      else echo "mysql_state : KO" >> auto7.txt 
fi

# On test phpmyadmin 


IP=$(ifconfig eth0 | grep 'inet adr:' | cut -d: -f 2 | awk '{print $1}')
curl $IP/phpmyadmin 1>php_ret 2>ERR # on met le résultat dans un fichier
chaine1=$(grep -o -w "404 Not Found" php_ret ) # on cherche la chaine 404 Not Found
chaine2=$(grep -o -w "Failed to connect to" ERR)

wget $IP/phpmyadmin -O php_wget 1>/dev/null 2>/dev/null

chaine3=$(grep -i "Welcome to" php_wget | cut -d">" -f 2 | cut -d"<" -f 1 | awk '{print $1}' )
# on cherche la chaine "welcome to " dans le fichier php_wget puis on prend juste "welcome" si cela existe bien sure


if [ "$chaine1" = "404 Not Found" ] || [ "$chaine2" = "Failed to connect to" ] || [ "$chaine3"  != "Welcome" ]
     then
          echo "phpmyadmin_state : KO" >> auto7.txt  
     else echo "phpmyadmin_state : OK" >> auto7.txt 
fi

# On teste et on modifie les utilisateurs  Mysql et Apache

# Mysql ***********************************************************
service mysql stop 

useradd $MYSQL_USER

MY_USER=$(grep -i "user\s" /etc/mysql/my.cnf | cut -d"=" -f 2 | awk '{print $1}' | head -n 1 )

if [ "$MY_USER" != "$MYSQL_USER" ]
 then
 sed -i 's/= '$MY_USER'/= '$MYSQL_USER' /g' /etc/mysql/my.cnf
fi

chown -R $MYSQL_USER /var/lib/mysql
chown -R $MYSQL_USER /var/run/mysqld

echo "$pid_sql" > /var/run/mysqld/mysqld.pid 

service mysql start 

# Apache ************************************************************

service apache2 stop

useradd $APACHE_USER

AP_USER=$(grep -i APACHE_RUN_USER= /etc/apache2/envvars | cut -d"=" -f 2 ) ;


if [ "$AP_USER" != "$APACHE_USER" ]
 then
  sed -i 's/export APACHE_RUN_USER='$AP_USER'/export APACHE_RUN_USER='$APACHE_USER' /g' /etc/apache2/envvars
fi

AP_GROUP=$(grep -i APACHE_RUN_GROUP= /etc/apache2/envvars | cut -d"=" -f 2 ) ;

if [ "$AP_GROUP" != "$APACHE_USER" ]
 then
  sed -i 's/export APACHE_RUN_GROUP='$AP_GROUP'/export APACHE_RUN_GROUP= '$APACHE_USER' /g' /etc/apache2/envvars
fi

chown -R $APACHE_USER /usr/sbin/apache2
chown -R $APACHE_USER /run/lock/apache2
chown -R $APACHE_USER /var/lib/phpmyadmin/tmp
chown -R $APACHE_USER /var/cache/tcpdf
chown -R $APACHE_USER /var/cache/apache2/mod_cache_disk

echo $pid_apache > /var/run/apache2/apache2$SUFFIX.pid 

service apache2 start

pid_mysql=$(ps -aux | grep -w beth | cut -d"?" -f 1 | awk '{print $2}' | sed -n '1p')
pid_apache=$(ps -aux | grep -w carl | cut -d"?" -f 1 | awk '{print $2}' | sed -n '1p')

AP_USER=$(grep -i APACHE_RUN_USER= /etc/apache2/envvars | cut -d"=" -f 2 )
MY_USER=$(grep -i "user\s" /etc/mysql/my.cnf | cut -d"=" -f 2 | awk '{print $1}' | head -n 1 )


echo "http_user_conf  : $AP_USER " >> auto7.txt  
echo "mysql_user_conf : $MY_USER " >> auto7.txt 

echo "http_user_pid   : $pid_apache" >> auto7.txt 
echo "http_user_pid   : $pid_mysql " >> auto7.txt 


