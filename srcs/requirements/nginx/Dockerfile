# Use Debian as the base image
FROM debian:bullseye

# Set a port
EXPOSE 443

# Refresh the package list
# Install NGINX and OpenSSL packages (-y installation without user input)
RUN apt-get update && apt-get upgrade
RUN apt-get install -y nginx openssl

# Copy NGINX configuration file to the container
COPY ./conf/nginx.conf /etc/nginx/conf.d

# Create a directory (/etc/nginx/ssl) where the SSL certificate and private key are stored
RUN mkdir /etc/nginx/ssl

# Generate self-signed SSL certificate and private key:
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt -subj "/C=CH/ST=Vaud/L=Lausanne/O=42Lausanne/CN=mmakarov.42.fr"

# Run NGINX config (needed?)
RUN mkdir -p /run/nginx

# Copy html files to the container
RUN cp -r /var/www/html /usr/share/nginx/html

# Set NGINX as the entrypoint, using the NGINX executable from the local installation
ENTRYPOINT ["nginx", "-g", "daemon off;"]
