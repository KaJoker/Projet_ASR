#!/bin/bash 
IP=$(ifconfig eth0 | grep 'inet adr:' | cut -d: -f 2 | awk '{print $1}')
curl $IP/phpmyadmin 1>php_ret 2>/dev/null # on met le résultat dans un fichier 
chaine=$(grep -o -w "404 Not Found" php_ret ) # on cherche la chaine 404 Not Found 
if [ "$chaine" = "404 Not Found" ] 
     then echo KO 
     else echo OK 
fi
