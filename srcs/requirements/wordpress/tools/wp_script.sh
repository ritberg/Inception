#!/bin/bash

# Check if WordPress files exist
if [ -d "/usr/share/nginx/html" ]; then
    echo "WordPress files already exist. Deleting existing files..."
    rm -rf /usr/share/nginx/html/*
fi

# Download WP-CLI to be able to use wp core download etc.
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# Download wordpress
wp core download --allow-root --path=/usr/share/nginx/html

# launch mariadb first
sleep 10

# Give permissions 
chmod 755 /usr/share/nginx/html/*

# Change ownership to give rights to the root
chown -R www-data:www-data /usr/share/nginx/html

# Change directory to WordPress installation directory
cd /usr/share/nginx/html

# Create the configuration file wp-config.php of wordpress
wp config create --allow-root --dbname=${DB_NAME} --dbuser=${DB_USER} --dbpass=${DB_PASSWORD} --dbhost=${DB_HOST}

# Install wordpress
wp core install --allow-root --url="mmakarov.42.fr" --title="My_website" --admin_user=${WP_USER} --admin_password=${WP_PASSWORD} --admin_email=${DB_ROOT_EMAIL}

# Create a wordpress user
wp user create bob --role=author --user_pass=222 --allow-root

exec /usr/sbin/php-fpm7.4 -F