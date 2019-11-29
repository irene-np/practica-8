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
sed -i "s/localhost/3.94.209.38/" config.php

#instalar wordpress
cd /var/www/html
wget https://wordpress.org/latest.tar.gz
tar -zxvf latest.tar.gz --strip-components=1
chown -R www-data:www-data /var/www/html/
chmod -R 755

# Instalar paquetes servidor NFS
apt-get update
apt-get install nfs-kernel-server

#Exportar directorio al servidor
chown nobody:nogroup /var/www/html/wp-content

# Editar archivo /etc/exports
cd /etc
rm -R exports
cd ~
cp practica-8/exports /etc

# Reiniciamos Servicio NFS
/etc/init.d/nfs-kernel-server restart

# Abrirmos puerto 2049 en la maquina

