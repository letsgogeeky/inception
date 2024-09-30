#!/bin/bash

# modify www.conf
sed -i "s/\${WORDPRESS_CONTAINER_NAME}/$WP_CONTAINER_NAME/g" /etc/php/8.2/fpm/pool.d/www.conf

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# install wordpress
cd /var/www/html
wp core download --allow-root

# wait for mariadb to be ready
while ! mysqladmin ping -h"$DB_CONTAINER_NAME" -u"$WORDPRESS_DB_USER" -p"$WORDPRESS_DB_PASSWORD" --silent; do
	echo "Waiting for MariaDB to be ready..."
	sleep 1
done

wp config create --dbname=$WORDPRESS_DB_NAME \
    --dbuser=$WORDPRESS_DB_USER \
    --dbpass=$WORDPRESS_DB_PASSWORD \
    --dbhost=$WORDPRESS_DB_HOST \
    --allow-root
wp core install --url=$WORDPRESS_URL \
    --title=$WORDPRESS_TITLE \
    --admin_user=$WORDPRESS_ADMIN_USER \
    --admin_password=$WORDPRESS_ADMIN_PASSWORD \
    --admin_email=$WORDPRESS_ADMIN_EMAIL \
    --allow-root

# Add an editor user
wp user create $WORDPRESS_EDITOR_USER $WORDPRESS_EDITOR_EMAIL --role=editor --user_pass=$WORDPRESS_EDITOR_PASSWORD --allow-root

# setup redis cache
wp plugin install redis-cache --activate --allow-root
# wp plugin install nginx-helper --activate --allow-root


# Enable redis cache
wp redis enable

# Check if redis is enabled
wp redis status

# Add redis configuration
wp config set WP_REDIS_HOST ${REDIS_HOST} --allow-root
wp config set WP_REDIS_PORT ${REDIS_PORT} --allow-root
wp config set FS_METHOD direct --allow-root
# wp config set WP_CACHE_KEY_SALT ${WORDPRESS_DB_NAME} --allow-root

php-fpm8.2 -F