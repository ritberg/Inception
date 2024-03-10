# Use Debian as the base image
FROM debian:bullseye-slim

# Set a port
EXPOSE 443

# Copy NGINX configuration file to the container
COPY ./conf/nginx.conf /etc/nginx/nginx.conf.d

# Refresh the package list
# Remove the APT package cache to reduce the size of the Docker image
# Install NGINX and OpenSSL packages (-y installation without user input)
RUN apt-get update && \
    rm -rf /var/lib/apt/lists/* 
RUN apt-get install -y nginx openssl

# Create a directory (/etc/nginx/ssl) where the SSL certificate and private key are stored
RUN mkdir /etc/nginx/ssl

# Generate self-signed SSL certificate and private key:
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt -subj "/C=CH/ST=Vaud/L=Lausanne/O=42Lausanne/CN=mmakarov.42.fr"

# Run NGINX config
#RUN mkdir -p /run/nginx

# Create a directory for website files
RUN mkdir -p /usr/share/nginx/html

# Copy website files to the container
COPY html /usr/share/nginx/html

# Set NGINX as the entrypoint, using the NGINX executable from the local installation
ENTRYPOINT ["nginx", "-g", "daemon off;"]
