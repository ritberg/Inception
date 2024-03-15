# Use Debian as the base image
FROM debian:bullseye

# Set a port
EXPOSE 3306

# Refresh the package list
# Install mariaDB packages (-y installation without user input)
RUN apt-get update && apt-get upgrade
RUN apt-get install -y mariadb-server mariadb-client

# Copy the .cnf file in /etc/mysql/mariadb.conf.d of the container
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d

# Copy the script .sh (and .sql?) file(s) to /var/local/bin/
COPY ./tools/db_script.sh /var/local/bin/
# COPY ./tools/db_database.sql /var/local/bin/

# Give execute permissions to mysqld (daemon) and the script
RUN chmod +x /usr/sbin/mysqld
RUN chmod +x /var/local/bin/db_script.sh

# Launch the script to install MariaDB
CMD ["bash", "/var/local/bin/db_script.sh"]
