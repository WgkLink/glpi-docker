#!/bin/sh

# Install GLPI
echo 'Installing GLPI'

wget https://github.com/glpi-project/glpi/releases/download/10.0.2/glpi-10.0.2.tgz /

tar -xzf glpi-10.0.2.tgz

mv glpi /var/www/glpi

chown -R www-data:www-data /var/www/glpi
chmod -R 775 /var/www/glpi/


/etc/init.d/php8.1-fpm start
nginx -g 'daemon off;'