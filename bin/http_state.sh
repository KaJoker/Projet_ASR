#!/bin/bash 
HTTP_STATE()
{
michon="michonne" # variable
echo "michonne" > /var/www/html/ping_me # On écrit le mot "michonne" sur le fichier ping_me
IP=$(ifconfig eth0 | grep 'inet adr:' | cut -d: -f 2 | awk '{print $1}') # On récupere l'IP de l'hôte 
#echo $IP  # verfication de l'IP 
verif=$(curl -s http://$IP/ping_me) # verif récupere le contenu de la page ping_me 
if [ "$verif" = "$michon" ]      # on verfie que le contenu de la variable michon = contenu de la variable verif
            then echo OK  
            else echo KO
fi
}
HTTP_STATE
