FROM php:8.2-apache

COPY ./dev-apache2.conf /etc/apache2/apache2.conf
COPY ./dev-ports.conf /etc/apache2/ports.conf

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -fqy \
    apt-utils \
    curl \
    default-mysql-client \
    git \
    iputils-ping \
    libargon2-dev \
    libcurl4-openssl-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libjson-c-dev \
    libldap-dev \
    libonig-dev \
    libpng-dev \
    libpq-dev \
    libxml2-dev \
    libxslt1-dev \
    libzip-dev \
    openssl \
    sqlite3 \
    unzip \
    vim \
    zip \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN curl -fsSL https://getcomposer.org/installer -o /tmp/composer-setup.php \
 && php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer \
 && rm /tmp/composer-setup.php

RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
 && DEBIAN_FRONTEND=noninteractive apt-get install -fqy nodejs \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN pecl install redis \
 && docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg \
 && docker-php-ext-install \
    bcmath \
    exif \
    gd \
    ldap \
    mbstring \
    mysqli \
    opcache \
    pcntl \
    pdo \
    pdo_mysql \
    pdo_pgsql \
    zip \
 && docker-php-ext-enable redis zip

COPY ./dev-apache-site.conf /etc/apache2/sites-enabled/000-default.conf

RUN openssl req -x509 -newkey rsa:4096 -keyout /etc/ssl/private/key.pem -out /etc/ssl/certs/cert.pem -days 365 -nodes -subj "/C=US/ST=NY/L=NY/O=ACME/OU=CD/CN=AcmeWPDeveloper" \
 && a2enmod ssl rewrite \
 && mkdir -p /var/www/uploads \
 && chown -R www-data:www-data /var/www/uploads

WORKDIR /var/www/html
