#!/bin/bash
# Actualizar PC
apt-get update

# 2. Instalar apache2
apt-get install apache2 -y
apt-get install php libapache2-mod-php php-mysql -y
apt-get install php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip -y
apt-get install php-fpm php-mysql -y

# Configuración de index
cd practica-8
cp 000-default.conf /etc/apache2/sites-available/

# Configuración de php-fpm
cd /etc/php/7.2/fpm/
sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0' php.ini

# Intalación de paquetes cliente NFS
apt-get install nfs-common -y


# Crear punto de montaje Cliente NFS
mount 3.87.4.15:/var/www/html/ /var/www/html/

# Montar directorio NFS
cd /etc/
echo "3.87.4.15:/var/www/html/ /var/www/html/  nfs auto,nofail,noatime,nolock,intr,tcp,actimeo=1800 0 0" > /etc/fstab





