#!/bin/bash

# Start MariaDB server
service mariadb start

# Wait for MariaDB to start
sleep 10

mkdir -p /var/run/mysqld
chown mysql:mysql /var/run/mysqld

# Create a database | log in to MySQL as root
echo "CREATE DATABASE ${DB_NAME};" | mariadb -u root

# Create a user with privileges on the database
echo "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';" | mariadb -u root

# Reload privileges
echo "FLUSH PRIVILEGES;" | mariadb -u root 

# Set root password 
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';" | mariadb -u root

# Stop MariaDB server (mariadb stop didn't work)
mysqladmin -u root -p${DB_ROOT_PASSWORD} shutdown

# Enable the database to listen to all IPV4 addresses
mysqld_safe
