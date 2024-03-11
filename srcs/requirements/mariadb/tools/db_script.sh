#!/bin/bash

# Start MariaDB server
service mariadb start

# Wait for mariaDB to start
sleep 5


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
mariadbd --bind-address=0.0.0.0 --user=mysql --datadir=/var/lib/mysql --socket=/var/run/mysqld/mysqld.sock
