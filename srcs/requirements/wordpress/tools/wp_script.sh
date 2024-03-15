#!/bin/bash

# Download WP-CLI to be able to use wp core download etc.
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# Download wordpress
wp core download --allow-root --path=/usr/share/nginx/html

# Give permissions 
chmod 755 /usr/share/nginx/html/*

# Change ownership to give rights to the root
chown -R www-data:www-data /usr/share/nginx/html

# Create the configuration file wp-config.php of wordpress
wp config create --allow-root --dbname=${DB_NAME} --dbuser=${DB_USER} 

# Install wordpress
wp core install --allow-root --url=localhost --title="My_website" --admin_user=${DB_USER} --admin_password=${DB_ROOT_PASSWORD} --admin_email=mmakarov@student.42lausanne.ch

/usr/sbin/php-fpm7.4 -F
