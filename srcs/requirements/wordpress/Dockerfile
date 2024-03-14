# Use Debian as the base image
FROM debian:bullseye

# Set a port
EXPOSE 9000

# Refresh the package list
# Install php-fpm(-y installation without user input)
RUN apt-get update && apt-get upgrade
RUN apt-get install -y php php-fpm curl php-mysql php-mysqli

# Copy the www.conf file in php/7.3/fpm/pool.d/
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/

# Create the php directory to enable php-fpm to run
RUN mkdir /run/php

# Copy the script files
COPY ./tools/wp_script.sh /var/www/html/php/wp_script.sh

# Give execute permissions to the script
RUN chmod +x /var/www/html/php/wp_script.sh

# Go to the html directory
WORKDIR /usr/share/nginx/html

# ENTRYPOINT ["/usr/sbin/php-fpm7.4", "-F"]

# Launch php-fpm
CMD ["bash", "/var/www/html/php/wp_script.sh"]
