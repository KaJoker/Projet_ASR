#!/bin/bash 
chaine1="truc"
chaine2="truc"
IP=$(ifconfig eth0 | grep 'inet adr:' | cut -d: -f 2 | awk '{print $1}')
curl $IP/phpmyadmin 1>php_ret 2>ERR # on met le résultat dans un fichier 
chaine1=$(grep -o -w "404 Not Found" php_ret ) # on cherche la chaine 404 Not Found 
chaine2=$(grep -o -w "Failed to connect to" ERR)

wget 127.0.0.1/phpmyadmin -O php_wget 1>/dev/null 2>/dev/null 
 
chaine3=$(grep -i "Welcome to" php_wget | cut -d">" -f 2 | cut -d"<" -f 1 | awk '{print $1}' )
# on cherche la chaine "welcome to " dans le fichier php_wget puis on prend juste "welcome" si cela existe bien sure 


if [ "$chaine1" = "404 Not Found" ] || [ "$chaine2" = "Failed to connect to" ] || [ "$chaine3"  != "Welcome" ] 
     then  
          echo "KO" 
     else echo "OK (<:) "  
fi  
