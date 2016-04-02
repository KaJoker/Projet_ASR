<h1>        Université d'Evry Val d'Esonne </h1> 
<h2> Projet d'administration systèmes et réseaux </h2>
<h3> L3 ASR 2015/2016 </h3> 
<h5>        Encadreur : M.Poligny </h5> 
</br> </br>
 <p style="text-align:center";>  <strong> Le Projet </strong> </p> 
<p> Le but de ce projet est d'installer d'une façon automatique et silencieuse : Phpmyadmin Mysql et apache2 </P> 
<p> les fichiers d'installation récupéent des variables à partir des fichiers de configurations </p> 
<p> le dossier BIN_V2.0 contient tous les scripts du projet</P> 
Pour commencer on lance le script : **Prog_Installation.sh**  ce script va éxecuter d'une maniére séquentielle ces scripts :
<p>
<ol>
    <li> <strong> install_phpmyadmin.sh install.conf </strong>:  installation de mysql , apache2 , phpmyadmin  </li>
    <li> <strong> question1.sh  </strong> : modification du nom de la machine et création d'un super-user carole  </li>
    <li> <strong> question3.sh  </strong> : script de verification de l'ensemble de l'installation   </li>
    <li> <strong> change_user.sh change.conf </strong> : changement automatique d'utilisateurs mysql et apache  </li>
    <li> <strong> question7.sh info7.conf  </strong>  : Automatisation de l'installation et de changement d'utilisateurs ... etc à partir d'une image inconnue  </li>
</ol>
</p>
