#!/bin/bash

FILE=/var/www/glpi

if [ -d "$FILE" ]; then
    echo "$FILE GLPI is installed."

    echo 'Ajusting permissions'
    chown www-data. /var/www/glpi -Rf
    find /var/www/glpi -type d -exec chmod 755 {} \;
    find /var/www/glpi -type f -exec chmod 644 {} \;

    # Reiniciar agendador de tarefas para ler as novas configurações
    echo 'Restarting cron'
    echo '* * * * * www-data /usr/bin/php /var/www/glpi/front/cron.php 2>&- 1>&-' >> /etc/cron.d/glpi
    service cron restart

    echo 'Starting php-fpm'
    /etc/init.d/php8.1-fpm start

    # Configuração do banco de dados
    echo 'Configuring database'
    php /var/www/glpi/bin/console db:configure -n -r -H $GLPI_DB_HOST -d $GLPI_DB_NAME -u $GLPI_DB_USER -p $GLPI_DB_PASSWORD

    RUN sed '1403s/$/ on/' -i /etc/php/8.1/fpm/php.ini


    echo 'Starting nginx'
    nginx -g 'daemon off;'
    
else
    echo "$FILE GLPI is not installed."
fi



