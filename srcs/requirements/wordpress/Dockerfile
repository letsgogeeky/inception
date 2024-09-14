# Use the official Debian base image
FROM debian:stable

# Install required packages
RUN apt-get update && apt-get install -y \
    apache2 \
    php \
    php-mysql \
    default-mysql-client \
    wordpress \
    wget curl

# Add ServerName to Apache configuration
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

EXPOSE 9000

# Start Apache web server
CMD ["apache2ctl", "-D", "FOREGROUND"]