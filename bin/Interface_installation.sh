#! /bin/bash 
bool=false       # bool pour éxectuter l'action num 2 
NOT_INSTALL=false # pour vérifier si on a éxecuter l'installation ou pas des programmes
USERS_CHANGED=false
USER_CREATED=false
while read -p  "
CHoisissez une action à éxecuter : 
                          1) : Creation d'un compte root et attribution du nom daryl à la machine 
                          2) : Installation de : 
                        		       a) Mysql server 
                     			       b) Phpmyadmin   
                   			       c) apache2      
			  3) : Tester l'installation ( après l'éxecution des étapes :  1) et 2) 
			  4) : Automatisation de l'installation à partir d'un fichier 
		          5) : Changement des utilisateurs  
		          6) : L'automatisation de changement des utiisateurs 
			  7) : Automatisation à partir d'une image inconnue  
		          8) : Réalisation d'images de test    
			  99): Exit the program  :)  
Choisissez un nombre puis appuyez sur Enter :) " touche ;
do
	case $touche in 
                 1) if $USER_CREATED 
                               then 
                                    echo "Utilisateur existe" 
                    else 
                         bash create_user; echo "le nom de la machine est : "; cat /etc/hostname; $USER_CREATED=true;  
                        
     	            fi ;;
                   2) if $NOT_INSTALL 
                              then 
                                    bash install_all.sh; $bool=true
                              else 
                                    echo "INSTALLATION dèja faite"
                    fi ;; 
                 3) if $bool
                                   then  
                                         bash total.sh;echo "\t"; cat information.txt;echo "\n"; 
                                   else  
                                         echo "Error : Etape 1 et 2 non exécutés " 
                          fi ;;
             	 4) if $NOT_INSTALL
                             then  bash install_all2.sh; $NOT_INSTALL=false 
                             else 
                                bash delete_all.sh; bash install2_all.sh;  $NOT_INSTALL=false 
                     fi ;;
                 5) if $NOT_INSTALL 
                       then
                              echo "Mysql server et/ou apache ne sont pas encore installés"
                       else 
                              bash question5.sh ; $USERS_CHANGED=true 
                   fi ;;
                 6) echo " Working on it (<:)" ;;
                 7) echo " Working on it too " ;; 
                 8) echo " 3 working on it ";;   
                 99) echo " Good bye ): \n" ; exit ;; 
     		 *)  echo " Choix impossible :/ \n "                
	esac 
done  
