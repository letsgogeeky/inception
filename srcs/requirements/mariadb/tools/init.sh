#!/bin/bash

# replace variables in init.sql with env variables
sed -e "s/\${WORDPRESS_DB_NAME}/$WORDPRESS_DB_NAME/g" \
    -e "s/\${WORDPRESS_DB_USER}/$WORDPRESS_DB_USER/g" \
    -e "s/\${WORDPRESS_DB_PASSWORD}/$WORDPRESS_DB_PASSWORD/g" \
    /docker-entrypoint-initdb.d/init.sql > /tmp/init.sql

cp /tmp/init.sql /etc/mysql/init.sql

rm /tmp/init.sql
