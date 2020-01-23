#!/bin/bash
# Actualizar PC
apt-get update

# 2. Instalar apache2
apt-get install apache2 -y

# Arrancar el apache2
systemctl start apache2 -y

# Instalar paquete
apt-get install php libapache2-mod-php php-mysql -y

# Instalación de php-fpm y php-mysql
apt-get install php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip -y
apt-get install php-fpm php-mysql -y

# Intalación de paquetes cliente NFS
apt-get update
apt-get install nfs-common -y

# Crear punto de montaje Cliente NFS
mount 54.210.32.185:/var/www/html/ /var/www/html/

# Montar directorio NFS
cd /etc/
echo "54.210.32.185:/var/www/html/ /var/www/html/  nfs auto,nofail,noatime,nolock,intr,tcp,actimeo=1800 0 0" > /etc/fstab





