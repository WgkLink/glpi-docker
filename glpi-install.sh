#!/bin/bash

# Install GLPI
echo 'Installing GLPI'
wget https://github.com/glpi-project/glpi/releases/download/10.0.2/glpi-10.0.2.tgz

echo 'Extracting GLPI'
tar -xzf glpi-10.0.2.tgz

echo 'Moving GLPI to /var/www/html'
mv glpi /var/www/

# AJUSTAR PERMISSÕES DE ARQUIVOS
echo 'Ajusting permissions'
chown www-data. /var/www/glpi -Rf
find /var/www/glpi -type d -exec chmod 755 {} \;
find /var/www/glpi -type f -exec chmod 644 {} \;

echo 'Starting php-fpm'
/etc/init.d/php8.1-fpm start

# Configuração do banco de dados
echo 'Configuring database'
php /var/www/glpi/bin/console db:configure -r -H $GLPI_DB_HOST -d $GLPI_DB_NAME -u $GLPI_DB_USER -p $GLPI_DB_PASSWORD
php /var/www/glpi/bin/console db:update --no-interaction --skip-db-checks --enable-telemetry

# Reajustando o acesso ao usuário do www-data
echo 'Reajusting www user access'
chown www-data. /var/www/glpi/files -Rf

echo 'Starting nginx'
nginx -g 'daemon off;'