# Use the official Debian base image
FROM debian:bookworm-slim

# Install required packages
RUN apt-get update && apt-get install -y \
    php-mysqli \
    default-mysql-client \
    php-fpm \
    wget curl \
    php-redis \
	redis-tools

ARG CACHEBUST=1

COPY ./conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf
COPY ./tools/wp_runner.sh /usr/local/bin/wp_runner.sh
RUN chmod +x /usr/local/bin/wp_runner.sh

CMD ["/usr/local/bin/wp_runner.sh"]