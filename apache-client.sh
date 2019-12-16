#!/bin/bash
# Actualizar PC
apt-get update

# 2. Instalar apache2
sudo apt-get install apache2 -y

# Arrancar el apache2
systemctl start apache2 -y

# Instalar paquete
apt-get install php libapache2-mod-php php-mysql -y

# Instalación de php-fpm y php-mysql
apt-get install php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip -y
apt-get install php-fpm php-mysql -y

# Instalamos la aplicacion
cd /var/www/html
git clone https://github.com/josejuansanchez/iaw-practica-lamp.git
chown www-data:www-data * -R

# Configuracion de index
cd ~
rm -rf practica-8
cp practica-8/000-default.conf /etc/apache2/sites-available/

# Configuración de php-fpm
cd /etc/php/7.2/fpm/
sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/' php.ini

# configurar el archivo config.php
cd /var/www/html/iaw-practica-lamp/src/
sed -i "s/localhost/54.210.32.185/" config.php

# Intalación de paquetes cliente NFS
apt-get update
apt-get install nfs-common -y

# Crear punto de montaje Cliente NFS
mount 54.210.32.185:/var/www/html/wp-content /var/www/html/wp-content

# Montar directorio NFS
cd /etc/
echo "54.210.32.185:/var/www/html/ /var/www/html/  nfs auto,nofail,noatime,nolock,intr,tcp,actimeo=1800 0 0" > /etc/fstab





