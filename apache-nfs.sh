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

# Reiniciamos el servicio nfs-kernel-server
 /etc/init.d/nfs-kernel-server restart

# Dirección del sitio y direccion URL
cd /var/www/html/
echo "define( 'WP_SITEURL', 'http://54.167.47.223' );" >> wp-config.php
echo "define( 'WP_HOME', 'http://54.167.47.223' );" >> wp-config.php

#Creamos uploads
mkdir /var/www/html/uploads -p

# Security Keys

#Borramos las keys 
cd /var/www/html/
sed -i '/AUTH_KEY/d' wp-config.php
sed -i '/LOGGED_IN_KEY/d' wp-config.php
sed -i '/NONCE_KEY/d' wp-config.php
sed -i '/AUTH_SALT/d' wp-config.php
sed -i '/SECURE_AUTH_SALT/d' wp-config.php
sed -i '/LOGGED_IN_SALT/d' wp-config.php
sed -i '/NONCE_SALT/d' wp-config.php

#Añadimos las keys
CLAVES=$(curl https://api.wordpress.org/secret-key/1.1/salt/)
CLAVES=$(echo $CLAVES | tr / _)
sed -i "/#@-/a $CLAVES" /var/www/html/wp-config.php
