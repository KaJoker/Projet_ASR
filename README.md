# Projet_ASR
<p> Le but de ce projet est d'installer d'une façon automatique et silencieuse : Phpmyadmin Mysql et apache2 </P> 
<p> les fichiers d'installation récupéent des variables à partir des fichiers de configurations </p> 
<p> le dossier BIN_V2.0 contient tous les scripts du projet</P> 
Pour lancer le programmes on lance le script : **Prog_Installation.sh**;  ce script va éxecuter d'une maniére séquentielle ces scripts : 
<ol>
    <li> install_phpmyadmin.sh install.conf </li>  **installation de mysql , apache2 , phpmyadmin**; 
    <li> question1.sh </li> ** modification du nom de la machine et création d'un super-user carole **; 
    <li> question3.sh  </li> ** script de verification de l'ensemble de l'installation **; 
    <li> change_user.sh change.conf </li> ** changement automatique d'utilisateurs mysql et apache **;
    <li> question7.sh info7.conf </li> ** Automatisation de l'installation et de changement d'utilisateurs ... etc à partir d'une image inconnue **; </li>
</ol>
