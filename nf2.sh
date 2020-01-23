#Actualizamos los repositorios
apt-get update

#Instalamos apache y paquetes
apt-get install apache2
apt-get install php libapache2-mod-php php-mysql
apt-get install php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip -y
apt-get install php-fpm php-mysql -y

# Descargamos Wordpress y descomprimimos
cd /var/www/html
wget https://wordpress.org/latest.tart.gz
tar -zxvf latest.tar.gz
# Modificamos el archivo wp-config-example.php
cd /var/www/html/wordpress
cp wp-config-sample.php wp-config.php
sed -i 's/database_name_here/wordpress/' wp-config.php
sed -i 's/username_here/wordpress/' wp-config.php
sed -i 's/password_here/wordpress/' wp-config.php
sed -i 's/localhost/52.23.209.106/' wp-config.php
# Concedemos permisos a Wordpress
chown -R www-data:www-data .

# Instalamos el servidor NFS
apt-get install nfs-kernel-server -y

# Cambiamos los permisos al directorio que vamos a compartir
chown nobody:nogroup /var/www/html/wordpress

# Editamos el archivo /etc/exports
cd /etc
echo "/var/www/html/wordpress/         18.233.224.39(rw,sync,no_root_squash,no_subtree_check)" > /etc/exports

# Reiniciamos el servicio nfs-kernel-server
/etc/init.d/nfs-kernel-server restart

# Dirección del sitio y direccion URL
cd /var/www/html/
echo "define( 'WP_SITEURL', 'http://54.167.47.223' );" >> wp-config.php
echo "define( 'WP_HOME', 'http://54.167.47.223' );" >> wp-config.php

#Creamos uploads
mkdir /var/www/html/uploads -p

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
