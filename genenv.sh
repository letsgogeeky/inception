#!/bin/bash

prompt_password() {
    local password
    local password_re
    local password_length
    while true; do
        password=""
        read -s -p "Enter password: " password
        password_length=${#password}
        if [ -z "$password" ]; then
            echo "Password cannot be empty. Please try again."
            continue
        fi
        if [ $password_length -lt 8 ]; then
            echo "Password must be at least 8 characters long."
            continue
        fi
        read -s -p "Re-enter password: " password_re
        if [ "$password" != "$password_re" ]; then
            echo "Passwords do not match. Please try again."
            continue
        fi
        break
    done
    echo "$password"
}

# Prompt the user for each variable
read -p "Enter DOMAIN_NAME (e.g., ramoussa.42.fr) default is 'ramoussa.42.fr': " DOMAIN_NAME
read -p "Enter PROJECT_NAME (e.g., inception) default is 'inception': " PROJECT_NAME
if [ -z "$DOMAIN_NAME" ]; then
    DOMAIN_NAME="ramoussa.42.fr"
fi
if [ -z "$PROJECT_NAME" ]; then
    PROJECT_NAME="inception"
fi
# Containers
DB_CONTAINER_NAME="${PROJECT_NAME}-mariadb"
WP_CONTAINER_NAME="${PROJECT_NAME}-wordpress"
NGINX_CONTAINER_NAME="${PROJECT_NAME}-nginx"

# Wordpress
WORDPRESS_DB_HOST="${DB_CONTAINER_NAME}:3306"
read -p "Enter WORDPRESS_DB_NAME (e.g., inception_wordpress): " WORDPRESS_DB_NAME
read -p "Enter WORDPRESS_DB_USER (e.g., godly): " WORDPRESS_DB_USER
echo "Enter WORDPRESS_DB_PASSWORD (at least 8 characters long)"
WORDPRESS_DB_PASSWORD=$(prompt_password)
read -p "Enter WORDPRESS_URL (e.g., https://localhost): " WORDPRESS_URL
read -p "Enter WORDPRESS_TITLE (e.g., Inception): " WORDPRESS_TITLE
read -p "Enter WORDPRESS_ADMIN_USER (e.g., ramoussa): " WORDPRESS_ADMIN_USER
echo "Enter WORDPRESS_ADMIN_PASSWORD (at least 8 characters long)"
WORDPRESS_ADMIN_PASSWORD=$(prompt_password)
read -p "Enter WORDPRESS_ADMIN_EMAIL (e.g., ramoussa@student.42heilbronn.de): " WORDPRESS_ADMIN_EMAIL
echo "Enter MYSQL_ROOT_PASSWORD (at least 8 characters long)"
MYSQL_ROOT_PASSWORD=$(prompt_password)

# Write the variables to the .env file
cat <<EOF > .env
DOMAIN_NAME=${DOMAIN_NAME}
PROJECT_NAME=${PROJECT_NAME}

# Containers
DB_CONTAINER_NAME=${DB_CONTAINER_NAME}
WP_CONTAINER_NAME=${WP_CONTAINER_NAME}
NGINX_CONTAINER_NAME=${NGINX_CONTAINER_NAME}

# Wordpress
WORDPRESS_DB_HOST=${WORDPRESS_DB_HOST}
WORDPRESS_DB_NAME=${WORDPRESS_DB_NAME}
WORDPRESS_DB_USER=${WORDPRESS_DB_USER}
WORDPRESS_DB_PASSWORD=${WORDPRESS_DB_PASSWORD}
WORDPRESS_URL=${WORDPRESS_URL}
WORDPRESS_TITLE=${WORDPRESS_TITLE}
WORDPRESS_ADMIN_USER=${WORDPRESS_ADMIN_USER}
WORDPRESS_ADMIN_PASSWORD=${WORDPRESS_ADMIN_PASSWORD}
WORDPRESS_ADMIN_EMAIL=${WORDPRESS_ADMIN_EMAIL}
MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
EOF

echo ".env file has been created successfully. please copy it to docker-compose.yml directory"