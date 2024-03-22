#!/bin/bash

service mariadb start

# Wait for MariaDB to start
sleep 5

mariadb -u root -e "CREATE DATABASE ${DB_NAME};"

# Create a user 
mariadb -u root -e "CREATE USER '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';"

# Create a user with privileges on the database
mariadb -u root -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';"

# Reload privileges
mariadb -u root -e "FLUSH PRIVILEGES;"

# Set root password 
mariadb -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';"

# Stop MariaDB server (mariadb stop didn't work)
mysqladmin -u root -p${DB_ROOT_PASSWORD} shutdown

# Enable the database to listen to all IPV4 addresses
mysqld_safe
