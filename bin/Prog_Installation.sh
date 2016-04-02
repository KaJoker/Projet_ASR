#! /bin/bash

echo "Info : Machine "; uname -a;
echo "Test des services avant l'installation :
                 				 a) MySql 
                          			 b) phpmyadmin 
			  			 c) Apache "

bash question3.sh
cat information.txt 
sleep 10 


echo "Installation de : Mysql, Phpmyadmin , Apache" 


bash install_phpmyadmin.sh install.conf 
bash question1.sh 
echo "Test des services après l'installation : 
                                                 a) MySql
                                                 b) phpmyadmin
                                                 c) Apache "

bash question3.sh 
cat information.txt 
sleep 10


echo "Changement automatique d'utilisateurs " 

bash change_user.sh change.conf
sleep 10 

echo " Automatisation à partir d'une image inconnue "

bash question7.sh info7.conf 

bash question8.sh 
