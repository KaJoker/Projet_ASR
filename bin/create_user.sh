#! /bin/bash 

hostname="rick"
hostname2=$(cat /etc/hostname)
if [ $hostname = $hostname2 ]
	then
		echo "Nom de la machine est : rick" # donc on a pas besoin de 
    # de faire une opération d'écriture sur le fichier 
	else

		echo "rick" > /etc/hostname  
		echo "127.0.1.1 rick" > /etc/hosts # un plus pôur le DNS c'est pas obligatoire 
fi
/etc/init.d/hostname.sh # pour MAJ le nom de la machine 
#tester utilisateur carole
user=$(grep -o -i "carole" /etc/passwd | cut -d':' -f 1)
if [ $user = "carole" ]
	then
		echo "Utilisateur dèja crée "; userdel carole; 
    # on supprime l'utilisateur carole s'il a été crée auparavant avec un mot de passe != de daryl !!
                  useradd "carole" # puis on le recrée à nouveau 
                  echo -e "carole:daryl" | chpasswd	
   else
		useradd "carole"
		echo -e "carole:daryl" | chpasswd
fi
apt-get -y install sudo # on installe "Sudo" pour donner les droits admin à un utilisateur 
echo -e "sudo carole ALL=ALL ALL" >> /etc/suders 
