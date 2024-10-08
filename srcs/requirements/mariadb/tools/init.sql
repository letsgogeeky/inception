CREATE DATABASE IF NOT EXISTS ${WORDPRESS_DB_NAME};

CREATE USER IF NOT EXISTS '${WORDPRESS_DB_USER}'@'%' IDENTIFIED BY '${WORDPRESS_DB_PASSWORD}';
GRANT ALL PRIVILEGES ON *.* TO '${WORDPRESS_DB_USER}'@'%';

FLUSH PRIVILEGES;
