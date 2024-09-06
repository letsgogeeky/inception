# Use the official Debian base image
FROM debian:stable

# Install required packages
RUN apt-get update && apt-get install -y \
    apache2 \
    php \
    php-mysql \
    mysql-client \
    wordpress

# Copy the WordPress configuration file
COPY wp-config.php /etc/wordpress/

# Expose port 80 for HTTP traffic
EXPOSE 80

# Start Apache web server
CMD ["apache2ctl", "-D", "FOREGROUND"]