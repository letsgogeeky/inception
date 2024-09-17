FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y \
    wget \
    php \
    php-mysql

# Download and extract Adminer
RUN wget https://www.adminer.org/latest.php -O /var/www/html/adminer.php
# RUN wget https://www.adminer.org/latest-mysql-en.php -O /var/www/html/adminer.php

# Expose port 81 because 80 is already used by Nginx
EXPOSE 81

# Grant permissions
RUN chmod 755 /var/www/html/adminer.php
RUN chown -R www-data:www-data /var/www/html/adminer.php

RUN rm -rf /var/www/html/index.html
# Start PHP
CMD ["php", "-S", "0.0.0.0:81", "-t", "/var/www/html/"]