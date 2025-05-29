FROM php:8.1-apache

# Instalar extensiones necesarias
RUN apt-get update && apt-get install -y \
    libzip-dev \
    pkg-config \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    zip \
    unzip \
    git \
    libonig-dev \
    libxml2-dev \
    mariadb-client \
    && docker-php-ext-install pdo_mysql mysqli gd xml zip opcache

# Activar mod_rewrite
RUN a2enmod rewrite

# Descargar Moodle
RUN curl -o /tmp/moodle.zip https://download.moodle.org/stable402/moodle-latest-402.zip && \
    unzip /tmp/moodle.zip -d /var/www/ && \
    mv /var/www/moodle /var/www/html && \
    chown -R www-data:www-data /var/www/html

# Configurar permisos
RUN chmod -R 755 /var/www/html