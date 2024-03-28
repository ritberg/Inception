# Use Debian as the base image
FROM debian:bullseye

# Set a port
EXPOSE 3306

# Refresh the package list
# Install mariaDB packages (-y installation without user input)
RUN apt-get update && apt-get upgrade
RUN apt-get install -y mariadb-server mariadb-client

# Copy the .cnf file in /etc/mysql/mariadb.conf.d of the container
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Copy the script .sh (and .sql?) file(s) to root
COPY ./tools/db_script.sh /
# COPY ./tools/db_database.sql /var/local/bin/

# copy the script that kills PID1 
COPY ./tools/kill_pid1.sh /

# Give execute permissions to mysqld (daemon) and the script
RUN chmod 555 /usr/sbin/mysqld
RUN chmod 555 /db_script.sh
RUN chmod 555 /kill_pid1.sh

# Launch the script to install MariaDB
CMD ["bash", "/kill_pid1.sh"]
