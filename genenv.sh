#!/bin/bash

# Prompt the user for each variable
read -p "Enter DOMAIN_NAME (e.g., intra.42.fr): " DOMAIN_NAME
read -p "Enter PROJECT_NAME: " PROJECT_NAME
read -p "Enter WORDPRESS_DB_USER: " WORDPRESS_DB_USER
read -p "Enter WORDPRESS_DB_PASSWORD: " WORDPRESS_DB_PASSWORD
read -p "Enter MYSQL_ROOT_PASSWORD: " MYSQL_ROOT_PASSWORD

# Define the container names based on the project name
DB_CONTAINER_NAME="${PROJECT_NAME}-mariadb"
WP_CONTAINER_NAME="${PROJECT_NAME}-wordpress"
NGINX_CONTAINER_NAME="${PROJECT_NAME}-nginx"
WORDPRESS_DB_NAME="${PROJECT_NAME}-wordpress"

# Write the variables to the .env file
cat <<EOF > .env
DOMAIN_NAME=${DOMAIN_NAME}
PROJECT_NAME=${PROJECT_NAME}

# Containers
DB_CONTAINER_NAME=${DB_CONTAINER_NAME}
WP_CONTAINER_NAME=${WP_CONTAINER_NAME}
NGINX_CONTAINER_NAME=${NGINX_CONTAINER_NAME}

# Wordpress
WORDPRESS_DB_NAME=${WORDPRESS_DB_NAME}
WORDPRESS_DB_USER=${WORDPRESS_DB_USER}
WORDPRESS_DB_PASSWORD=${WORDPRESS_DB_PASSWORD}
MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
EOF

echo ".env file has been created successfully. please copy it to docker-compose.yml directory"