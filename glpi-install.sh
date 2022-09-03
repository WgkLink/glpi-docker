#!/bin/bash

# Install GLPI
echo 'Installing GLPI'

wget https://github.com/glpi-project/glpi/releases/download/10.0.2/glpi-10.0.2.tgz

tar -xzf glpi-10.0.2.tgz

mv glpi /var/www/glpi

# AJUSTAR PERMISSÕES DE ARQUIVOS
chown www-data. /var/www/glpi -Rf
find /var/www/glpi -type d -exec chmod 755 {} \;
find /var/www/glpi -type f -exec chmod 644 {} \;


/etc/init.d/php8.1-fpm start
nginx -g 'daemon off;'