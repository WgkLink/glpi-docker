FROM ubuntu:latest

ENV TZ=America/Sao_Paulo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get upgrade -y && apt-get autoremove -y && apt-get install -y\
    php8.1 \
    php8.1-fpm \
    php8.1-mysql \
    php8.1-xml \
    php8.1-curl \
    php8.1-gd \
    php8.1-mbstring \
    php8.1-zip \
    php8.1-fileinfo \
    php8.1-mysqli \
    php8.1-simplexml \
    php8.1-cli \
    php8.1-ldap \
    php8.1-xmlrpc \
    php8.1-APCu \
    php8.1-intl \
    php8.1-bz2 \
    wget \
    git \
    nginx \
    cron

COPY entrypoint-docker.sh / 
COPY nginx/default /etc/nginx/sites-available/default
#COPY nginx/certificate.crt /etc/nginx/certs/certificate.crt
#COPY nginx/certificate.key /etc/nginx/certs/certificate.key

RUN chmod +x /entrypoint-docker.sh

ENTRYPOINT [ "bash", "/entrypoint-docker.sh" ]