#!/bin/bash
# Actualizar PC
apt-get update

#Instalamos adminer
cd /var/www/html
mkdir adminer
cd adminer
wget https://github.com/vrana/adminer/releases/download/v4.7.3/adminer-4.7.3-mysql.php
mv adminer-4.7.3-mysql.php index.php

# 2. Instalar apache2
sudo apt-get install apache2 -y

# Arrancar el apache2
systemctl start apache2

# Instalar paquete
apt-get install php libapache2-mod-php php-mysql -y

# Instalamos git
apt-get install git -y

# Instalamos la aplicacion
cd /var/www/html
git clone https://github.com/josejuansanchez/iaw-practica-lamp.git
chown www-data:www-data * -R

# configurar el archivo config.php
cd /var/www/html/iaw-practica-lamp/src/
sed -i "s/localhost/54.210.32.185/" config.php

# Intalación de paquetes cliente NFS
apt-get update
apt-get install nfs-common

# Crear punto de montaje Cliente NFS
mount 54.210.32.185:/var/www/html/wp-content /var/www/html/wp-content

# Montar directorio NFS
cd /etc
rm -r fstab
cd ~
cp practica-8/fstab.sh /etc





