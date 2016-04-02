#! /bin/bash


echo  "phpmyadmin phpmyadmin/dbconfig-remove boolean true" |debconf-set-selections 
echo  "dbconfig-common  dbconfig-common/dbconfig-remove  boolean true" | debconf-set-selections 
echo  "mysql-server-5.5 mysql-server-5.5/postrm_remove_databases   boolean true"| debconf-set-selections
echo  "dbconfig-common dbconfig-common/pgsql/changeconf boolean false" | debconf-set-selections
echo  "dbconfig-common dbconfig-common/dbconfig-remove boolean true" |debconf-set-selections 
echo  "dbconfig-common dbconfig-common/remove-error select abort" |debconf-set-selections 

apt-get -y remove  mysql-server mysql-client mysql-common phpmyadmin apache2
apt-get -y purge   mysql-server mysql-client mysql-common phpmyadmin apache2

