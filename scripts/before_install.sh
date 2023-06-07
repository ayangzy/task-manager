#!/usr/bin/env bash

# Remove the existing Laravel application files
sudo rm -rf /home/ubuntu/var/www/task-manager/*

# Update system packages
sudo apt update

# Install PHP dependencies
sudo apt install -y \
    php8.0-common \
    php8.0-mysql \
    php8.0-xml \
    php8.0-xmlrpc \
    php8.0-curl \
    php8.0-gd \
    php8.0-imagick \
    php8.0-cli \
    php8.0-dev \
    php8.0-imap \
    php8.0-mbstring \
    php8.0-opcache \
    php8.0-soap \
    php8.0-zip \
    php8.0-intl \
    php8.0-fpm

# Install Nginx
sudo apt install -y nginx

# Start Nginx service
sudo systemctl start nginx

# Enable Nginx to start on system boot
sudo systemctl enable nginx

# Install Composer
EXPECTED_SIGNATURE="$(wget -q -O - https://composer.github.io/installer.sig)"
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
ACTUAL_SIGNATURE="$(php -r "echo hash_file('SHA384', 'composer-setup.php');")"

if [[ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]]; then
    >&2 echo 'ERROR: Invalid composer installer signature'
    rm composer-setup.php
    exit 1
fi

php composer-setup.php --install-dir=/usr/local/bin --filename=composer

# Remove composer-setup.php
rm composer-setup.php

# Verify Composer installation
composer --version
