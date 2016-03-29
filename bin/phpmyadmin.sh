#!/bin/bash 
chaine1="truc"
chaine2="truc"
IP=$(ifconfig eth0 | grep 'inet adr:' | cut -d: -f 2 | awk '{print $1}')
curl $IP/phpmyadmin 1>php_ret 2>ERR # on met le résultat dans un fichier 
chaine1=$(grep -o -w "404 Not Found" php_ret ) # on cherche la chaine 404 Not Found 
chaine2=$(grep -o -w "Failed to connect to" ERR)

if [ "$chaine1" = "404 Not Found" ] || [ "$chaine2" = "Failed to connect to" ] 
     then echo KO 
     else echo OK 
fi
