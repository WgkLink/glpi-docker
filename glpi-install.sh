#!/bin/bash

# Install GLPI
echo 'Installing GLPI'
wget https://github.com/glpi-project/glpi/releases/download/10.0.2/glpi-10.0.2.tgz

echo 'Extracting GLPI'
tar -xzf glpi-10.0.2.tgz

echo 'Moving GLPI to /var/www/'
mv glpi /var/www/
cp -r /var/www/config/* /var/www/glpi/config
cp -r /var/www/files/* /var/www/glpi/files
cp -r /var/www/marketplace/* /var/www/glpi/marketplace
cp -r /var/www/plugins/* /var/www/glpi/plugins

# AJUSTAR PERMISSÕES DE ARQUIVOS
echo 'Ajusting permissions'
chown www-data. /var/www/glpi -Rf
find /var/www/glpi -type d -exec chmod 755 {} \;
find /var/www/glpi -type f -exec chmod 644 {} \;

# Criar entrada no agendador de tarefas do Linux
echo 'Creating cron entry'
echo -e "* *\t* * *\troot\tphp /var/www/glpi/front/cron.php" >> /etc/crontab
 
# Reiniciar agendador de tarefas para ler as novas configurações
echo 'Restarting cron'
service cron restart

echo 'Starting php-fpm'
/etc/init.d/php8.1-fpm start

# Configuração do banco de dados
echo 'Configuring database'
php /var/www/glpi/bin/console db:configure -n -r -H $GLPI_DB_HOST -d $GLPI_DB_NAME -u $GLPI_DB_USER -p $GLPI_DB_PASSWORD
php /var/www/glpi/bin/console db:update --no-interaction --skip-db-checks --enable-telemetry
php /var/www/glpi/bin/console glpi:migration:utf8mb4 --no-interaction
php /var/www/glpi/bin/console glpi:migration:unsigned_keys --no-interaction

# Removendo pasta install
echo 'Remove install.php'
rm -rf /var/www/glpi/install/install.php

# Reajustando o acesso ao usuário do www-data
echo 'Reajusting www user access'
chown www-data. /var/www/glpi/files -Rf

echo 'Starting nginx'
nginx -g 'daemon off;'