#! /bin/bash 
bool=false       # bool pour éxectuter l'action num 2 
NOT_INSTALL=true # pour vérifier si on a éxecuter l'installation ou pas des programmes
USERS_CHANGED=false
USER_CREATED=false
while read -p " CHoisissez une action à éxecuter : 
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
                          9) : Tester la connexion avec  ping google.com   
			  99): Exit the program  :)  
Choisissez un nombre puis appuyez sur Enter :) " touche ;
do
	case $touche in 
                 1) if $USER_CREATED # on teste si on a dèja éxecuter cette opération 
                               then 
                                    echo "Utilisateur existe" 
                    else
                         bash question1.sh 
                        echo "le nom de la machine est : "; cat /etc/hostname; USER_CREATED=true;  
                        
     	            fi ;;
                 2) if $NOT_INSTALL # si la premiére installation
                              then 
                                    bash question2.sh; NOT_INSTALL=false; bool=true # installation faite 
                              else 
                                    echo "INSTALLATION dèja faite"
                    fi ;; 
                 3) if $bool # on peut éxecuter cette opération SSI on a jèja éxecuter 1 et 2 
                                   then  
                                         bash question3.sh;echo "\t"; cat information.txt;echo "\n"; 
                                   else  
                                         echo "Error : Etape 1 et 2 non exécutés " 
                          fi ;;
               	 4) if $NOT_INSTALL  # Si la 1er installation on installe directement 
                             then  bash install_phpmyadmin.sh install.conf; NOT_INSTALL=false 
                             else 
                                bash delete_all.sh; bash install_phpmyadmin.sh install.conf;  # sinon on 
 									   # supprime la 1ér installation 
                     fi ;;
                 5) if $NOT_INSTALL 
                       then
                              echo "Mysql server et/ou apache ne sont pas encore installés"
                       else 
                              bash question5.sh ; USERS_CHANGED=true 
                   fi ;;
                 6) echo " Working on it (<:)" ;;
                 7) echo " Working on it too " ;; 
                 8) echo " 3 working on it ";;   
                 9) ping  "google.com" ;; 
                 99) echo " Good bye ): \n" ; exit ;; 
     		 *)  echo " Choix impossible :/ \n "                
	esac 
done  
