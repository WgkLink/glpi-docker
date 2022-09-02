FROM ubuntu:latest

RUN apt-get update && apt-get upgrade -y && apt-get autoremove -y && apt-get install -y \
    git \
    nginx \
    php8.1 \
    php8.1-fpm \
    php8.1-mysql \
    php8.1-xml \
    php8.1-curl \
    php8.1-gd \
    php8.1-mbstring \
    php8.1-zip \
    php8.1-fileinfo \
    php8.1-json \
    php8.1-mysqli \
    php8.1-session \
    php8.1-zlib \
    php8.1-simplexml \
    php8.1-int1 \
    php8.1-cli \
    php8.1-domxml \
    php8.1-ldap \
    php8.1-xmlrpc \
    php8.1-openssl \
    php8.1-APCu


    