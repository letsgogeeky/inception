# Use the official Debian base image
FROM debian:bookworm-slim

# Install required packages
RUN apt-get update && apt-get install -y \
    php-mysql \
    default-mysql-client \
    php-fpm \
    wget curl

CMD ["php-fpm8.2", "-F"]