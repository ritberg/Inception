# Use Debian as the base image
FROM debian:bullseye

# Refresh the package list
# Install php-fpm(-y installation without user input)
RUN apt-get update && apt-get upgrade
RUN apt-get install -y php7.3-fpm

# Copy the www.conf file in php/7.3/fpm/pool.d/
COPY www.conf /etc/php/7.3/fpm/pool.d/

# Create the php directory to enable php-fpm to run
RUN mkdir /var/www/html/php

# Copy the script files
COPY ./tools/wp_script.sh /var/www/html/php/wp_script.sh

# Give execute permissions to the script
RUN chmod +x /var/www/html/php/wp_script.sh

# Go to the html directory
WORKDIR /var/www/html

# Launch php-fpm
CMD ["php-fpm", "-F"]
