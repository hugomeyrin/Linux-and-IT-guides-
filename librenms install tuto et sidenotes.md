AVEC LE TUTO DE INSTALLATION opennms ubuntu lxc 18.04 lts

terminal et en root :

```


Installer et configurer LibreNMS
Publié par Novakin le 11 mars 2016

Vous ne vous en souvenez peut être pas mais j’avais rédigé, il y a déjà quelque temps, un article vous expliquant comment installer et configurer Observium. Il existe depuis quelques temps un fork d’Observium : LibreNMS. Je vais donc ici expliquer comment installer et configurer LibreNMS (Apache / NGinx).

 

 
Pourquoi utiliser LibreNMS plutot qu’Observium ?

Observium se décline en deux versions : Observium Community Edition et Observium Profesionnal. Comme vous l’avez certainement déjà compris seule la Community Edition est gratuite et elle n’est mise à jour que tous les 6 mois. Si cela ne vous suffit pas pour vous encourager à passer à LibreNMS sachez que ce dernier ne collecte aucune donnée d’utilisation.

Les développeurs de LibreNMS sont donc partis de la dernière version d’Observium disponible sous licence GPL. A noter qu’il existe un script de migration, vous pouvez donc le tester, de mon coté j’ai préféré partir de zéro.
Prerequisites

In order to complete this tutorial, you will need to have an Ubuntu 18.04 server with a non-root sudo-enabled user account and a basic firewall. This can be configured using our initial server setup guide for Ubuntu 18.04.
Step 1 — Installing Apache and Updating the Firewall

The Apache web server is among the most popular web servers in the world. It’s well-documented and has been in wide use for much of the history of the web, which makes it a great default choice for hosting a website.

Install Apache using Ubuntu’s package manager, apt:

    sudo apt update
    sudo apt install apache2

Since this is a sudo command, these operations are executed with root privileges. It will ask you for your regular user’s password to verify your intentions.

Once you’ve entered your password, apt will tell you which packages it plans to install and how much extra disk space they’ll take up. Press Y and hit ENTER to continue, and the installation will proceed.
Adjust the Firewall to Allow Web Traffic

Next, assuming that you have followed the initial server setup instructions and enabled the UFW firewall, make sure that your firewall allows HTTP and HTTPS traffic. You can check that UFW has an application profile for Apache like so:

    sudo ufw app list

Output
Available applications:
  Apache
  Apache Full
  Apache Secure
  OpenSSH

If you look at the Apache Full profile, it should show that it enables traffic to ports 80 and 443:

    sudo ufw app info "Apache Full"

Output
Profile: Apache Full
Title: Web Server (HTTP,HTTPS)
Description: Apache v2 is the next generation of the omnipresent Apache web
server.

Ports:
  80,443/tcp

Allow incoming HTTP and HTTPS traffic for this profile:

    sudo ufw allow in "Apache Full"

You can do a spot check right away to verify that everything went as planned by visiting your server’s public IP address in your web browser (see the note under the next heading to find out what your public IP address is if you do not have this information already):

http://your_server_ip

You will see the default Ubuntu 18.04 Apache web page, which is there for informational and testing purposes. It should look something like this:
 

 
Installer et configurer LibreNMS

Dans ce post je pars du principe que :

    un serveur web est déjà installé sur votre serveur (Apache2 ou NGinx)
sudo apt install apache2


    un serveur SQL est déjà installé sur votre serveur (MySQL-server ou MariaDB)
 How To Install MySQL on Ubuntu 18.04 (Bionic)

Run below commands to upgrade the current packages to the latest version.

******sudo apt update 
*******sudo apt upgrade

Step 3 – Install MySQL on Ubuntu 18.04

Your system is ready for the MySQL installation. Run the following commands to install MySQL on Ubuntu 18.04 system.

*****sudo apt update 
*******sudo apt install mysql-server

The installation process will prompt for the root password to set as default. Input a secure password and same to confirm password window. This will be MySQL root user password required to log in to MySQL server.

MySQL on Ubuntu 18.04

MySQL on Ubuntu 18.04
Step 4 – Secure MySQL Installation
pas fait en.................

Step 5 – Connect to MySQL

The MySQL server has been installed on your system. Now connect to the MySQL database using the command line. Use root account password set in above step.

****** mysql -u root -p

SHOW GRANTS FOR 'librenms'@localhost;
GRANT ALL PRIVILEGES ON librenms.* TO 'librenms'@localhost IDENTIFIED BY 'smkool2019';
FLUSH PRIVILEGES;




    vous avez ajouté les dépots dotdeb

--------------------------------------------------------------
Installer PHP 7 sous Debian : Installation du dépôt dotdeb

Modifions notre fichier sources.list

sudo nano /etc/apt/sources.list

 

Ajoutons les lignes suivantes

*****deb http://packages.dotdeb.org jessie all
*****deb-src http://packages.dotdeb.org jessie all

 

Récupérons et installons la clé GnuPG

*****wget https://www.dotdeb.org/dotdeb.gpg
*****sudo apt-key add dotdeb.gpg

 

Mettez à jour la liste des paquets disponibles

****sudo apt-get update

 

 
Installer PHP 7 sous Debian : Installations des paquets

Ici c’est tout bete, il suffit de lancer la commande suivante

******sudo apt-get install php7.0

 

Les extensions sont aussi disponibles

*****sudo apt install php7.0 php7.0-fpm php7.0-mysql php7.0-curl php7.0-json php7.0-gd php7.0-mcrypt php7.0-msgpack php7.0-memcached php7.0-intl php7.0-sqlite3 php7.0-gmp php7.0-geoip php7.0-mbstring php7.0-xml php7.0-zip

 

Voilà ! À noter que si vous souhaitez vérifier la version de php installée sur votre système il vous suffit de lancer la commande suivante

php --version


 -----------------------------------------------------------------------
Installer LibreNMS

Il va falloir comme d’habitude installer quelques paquets.

sudo apt-get install php7.0-cli php7.0-mysql php7.0-gd php7.0-snmp php-pear php7.0-curl php7.0-fpm snmp graphviz php7.0-mcrypt php7.0-json nginx-full fping imagemagick whois mtr-tiny nmap python-mysqldb snmpd php-net-ipv4 php-net-ipv6 rrdtool git


*****a la main
apt-get install snmpd,php7.0-snmp php7.0-mysql php7.0-cli php-pear
php7.0-curl php7.0-fpm snmp graphviz php7.0-mcrypt php7.0-json
 fping imagemagick whois mtr-tiny nmap python-mysqldb snmpd rrdtool git
*********************************************19:00
manque (pas trouvé dans les dépôts)php7.0-gd et php-net-ipv4 php-net-ipv6
**********************************************

Modifiez la configuration snmpd

*******sudo nano /etc/snmp/snmpd.conf

 

***Ajoutez la ligne suivante
a la fin
****rocommunity public 127.0.0.1

 

****Sauvegardez le fichier et redémarrez snmpd

    ****sudo service snmpd restart

 

*****Vous pouvez maintenant télécharger LibreNMS

***cd /opt
***sudo git clone https://github.com/librenms/librenms.git librenms
cd /opt/librenms

 

Créez les dossiers qui contiendront graphs et logs

sudo mkdir rrd logs
sudo chmod 775 rrd

 

 
Configurer LibreNMS
Configuration de la base de données

Commencez par créer un utilisateur et une base de donnée

mysql -u root -p
<mysql root password>
mysql> CREATE DATABASE librenms_db;
mysql> GRANT ALL PRIVILEGES ON librenms_db.* TO 'root'@'localhost'
    IDENTIFIED BY 'smkool2019';
****fait et ok aussi 

 

mysql> GRANT ALL PRIVILEGES ON librenms_db.* TO 'librenms_user'@'localhost' IDENTIFIED BY 'smkool2019';
**** fait et ok 

 ***sudo useradd librenms -d /opt/librenms -M -r
Configuration de l’interface web

Nous allons créer un utilisateur système librenms et l’ajouter au groupe www-data

***sudo useradd librenms -d /opt/librenms -M -r
sudo usermod -a -G librenms www-data
sudo chown -R librenms:librenms /opt/librenms
cd /opt/librenms
chmod 777 -R librenms/
 

Si vous utilisez Apache2

Créez un nouveau vhost

sudo nano /etc/apache2/sites-available/librenms.conf

 

Utilisez la configuration ci-dessous (Apache 2.4 minimim).

<VirtualHost *:80>
 DocumentRoot /opt/librenms/html/
 ServerName librenms.votre-domaine.tld
 CustomLog /opt/librenms/logs/access_log combined
 ErrorLog /opt/librenms/logs/error_log
 NoDecode
 <Directory "/opt/librenms/html/">
 Require all granted
 AllowOverride All
 Options FollowSymLinks MultiViews
 </Directory>
</VirtualHost>

 

Activez cette configuration ainsi que le mod rewrite puis relancez votre instance d’Apache2

sudo a2ensite librenms.conf
sudo a2enmod rewrite
sudo service apache2 restart

 

Si vous utilisez NGinx

Créez un nouveau vhost

sudo nano /etc/nginx/sites-enabled/librenms.conf

 

Utilisez la configuration ci-dessous

server {
 listen 80;
 server_name librenms.votre-domaine.tld;

 root /opt/librenms/html;
 index index.php index.html index.htm;

 access_log /var/log/librenms.access.log;
 error_log /var/log/librenms.error.log warn;

 client_max_body_size 15M;

 location / {
 try_files $uri $uri/ /index.php?q=$uri&$args;
 }

 location ~ \.php$ {
 try_files $uri =404;
 fastcgi_split_path_info ^(.+\.php)(/.+)$;
 fastcgi_pass unix:/var/run/php/php7.0-fpm.sock;
 fastcgi_index index.php;
 fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
 fastcgi_read_timeout 60;
 include fastcgi_params;
 }

 location ~* \.(jpg|jpeg|png|gif|ico)$ {
 expires 365d;
 }
 location ~* \.(pdf|css|js|swf|woff|otf|ttf|svg)$ {
 expires 30d;
 }
}

 

Testez votre configuration et relancez NGinx

sudo nginx -t
sudo service nginx reload

 
Configuration de PHP

 
Cette étape est vitale, si vous ne configurez pas de fuseau horaire LibreNMS ne vous affichera aucun graphique

 

Si ce n’est pas déjà fait définissez votre fuseau horaire dans la configuration PHP : /etc/php/7.0/fpm/php.ini et /etc/php5/cli/php.ini . Recherchez la ligne

;date.timezone =

 

et modifiez la selon votre configuration, ici

date.timezone = Europe/Paris

 

Une fois ces modifications effectuées relancez php-fpm

systemctl restart php7.0-fpm.service

 
Configuration du cron

Créez le cron

sudo cp /opt/librenms/librenms.nonroot.cron /etc/cron.d/librenms

 

 
Terminer l’installation

Connectez vous à l’adresse sur laquelle vous avez configuré votre vhost, et renseignez les informations demandées :

    adresse de la base de donnée : localhost
    nom de la base de données : librenms
    mot de passe de la base de données : ce que vous avez choisi
    login de la base de données : librenms


 
Mettre à jour LibreNMS

Pour mettre à jour LibreNMS rien à faire : des mises à jour sont effectuées tous les jours à 00h15 (heure de votre serveur)




AUTRE MÉTHODE 

https://www.youtube.com/watch?v=VfuiSdBRbcc
```