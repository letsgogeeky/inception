FROM debian:stable

# Install required packages for wordpress
RUN apt-get update && apt-get install -y \
    apache2 \
    php \
    php-mysql \
    default-mysql-client \
    wget curl unzip

# Download and extract the latest version of WordPress
RUN wget https://wordpress.org/latest.tar.gz
RUN tar -xvzf latest.tar.gz
RUN mv wordpress /var/www/html/wordpress

# Add ServerName to Apache configuration
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

