import getpass

def prompt_password():
    while True:
        password = getpass.getpass("Enter password: ")
        password_length = len(password)
        
        if not password:
            print("Password cannot be empty. Please try again.")
            continue
        
        if password_length < 8:
            print("Password must be at least 8 characters long.")
            continue
        
        password_re = getpass.getpass("Re-enter password: ")
        if password != password_re:
            print("Passwords do not match. Please try again.")
            continue
        
        break
    
    return password

def prompt_input(prompt, default=None):
    user_input = input(prompt)
    if not user_input and default is not None:
        return default
    return user_input

# Prompt the user for each variable
DOMAIN_NAME = prompt_input("Enter DOMAIN_NAME (e.g., ramoussa.42.fr) default is 'ramoussa.42.fr': ", "ramoussa.42.fr")
PROJECT_NAME = prompt_input("Enter PROJECT_NAME (e.g., inception) default is 'inception': ", "inception")

# Containers
DB_CONTAINER_NAME = f"{PROJECT_NAME}-mariadb"
WP_CONTAINER_NAME = f"{PROJECT_NAME}-wordpress"
NGINX_CONTAINER_NAME = f"{PROJECT_NAME}-nginx"
REDIS_CONTAINER_NAME = f"{PROJECT_NAME}-redis"
FTP_CONTAINER_NAME = f"{PROJECT_NAME}-ftp"
ADMINER_CONTAINER_NAME = f"{PROJECT_NAME}-adminer"

# Wordpress
WORDPRESS_DB_HOST = f"{DB_CONTAINER_NAME}:3306"
WORDPRESS_DB_NAME = prompt_input("Enter WORDPRESS_DB_NAME (e.g., inception_wordpress): ", "inception_wordpress")
WORDPRESS_DB_USER = prompt_input("Enter WORDPRESS_DB_USER (e.g., godly): ", "godly")
print("Enter WORDPRESS_DB_PASSWORD (at least 8 characters long)")
WORDPRESS_DB_PASSWORD = prompt_password()
WORDPRESS_URL = prompt_input("Enter WORDPRESS_URL (e.g., https://localhost): ", DOMAIN_NAME)
WORDPRESS_TITLE = prompt_input("Enter WORDPRESS_TITLE (e.g., Inception): ", "Inception")
WORDPRESS_ADMIN_USER = prompt_input("Enter WORDPRESS_ADMIN_USER (e.g., ramoussa): ", "ramoussa")
print("Enter WORDPRESS_ADMIN_PASSWORD (at least 8 characters long)")
WORDPRESS_ADMIN_PASSWORD = prompt_password()
WORDPRESS_ADMIN_EMAIL = prompt_input("Enter WORDPRESS_ADMIN_EMAIL (e.g., anything@gmail.com): ")
print("Enter MYSQL_ROOT_PASSWORD (at least 8 characters long)")
MYSQL_ROOT_PASSWORD = prompt_password()
FTP_USER = prompt_input("Enter FTP_USER (e.g., ftpuser): ", "ftpuser")
print("Enter FTP_PASSWORD (at least 8 characters long)")
FTP_PASSWORD = prompt_password()

# Write the variables to the .env file
with open(".env", "w") as env_file:
    env_file.write(f"DOMAIN_NAME={DOMAIN_NAME}\n")
    env_file.write(f"PROJECT_NAME={PROJECT_NAME}\n\n")
    # Containers
    env_file.write(f"# Containers\n")
    env_file.write(f"DB_CONTAINER_NAME={DB_CONTAINER_NAME}\n")
    env_file.write(f"WP_CONTAINER_NAME={WP_CONTAINER_NAME}\n")
    env_file.write(f"NGINX_CONTAINER_NAME={NGINX_CONTAINER_NAME}\n")
    env_file.write(f"REDIS_CONTAINER_NAME={REDIS_CONTAINER_NAME}\n\n")
    env_file.write(f"FTP_CONTAINER_NAME={FTP_CONTAINER_NAME}\n")
    env_file.write(f"ADMINER_CONTAINER_NAME={ADMINER_CONTAINER_NAME}\n\n")
    # Wordpress
    env_file.write(f"# Wordpress\n")
    env_file.write(f"WORDPRESS_DB_HOST={WORDPRESS_DB_HOST}\n")
    env_file.write(f"WORDPRESS_DB_NAME={WORDPRESS_DB_NAME}\n")
    env_file.write(f"WORDPRESS_DB_USER={WORDPRESS_DB_USER}\n")
    env_file.write(f"WORDPRESS_DB_PASSWORD={WORDPRESS_DB_PASSWORD}\n")
    env_file.write(f"WORDPRESS_URL={WORDPRESS_URL}\n")
    env_file.write(f"WORDPRESS_TITLE={WORDPRESS_TITLE}\n")
    env_file.write(f"WORDPRESS_ADMIN_USER={WORDPRESS_ADMIN_USER}\n")
    env_file.write(f"WORDPRESS_ADMIN_PASSWORD={WORDPRESS_ADMIN_PASSWORD}\n")
    env_file.write(f"WORDPRESS_ADMIN_EMAIL={WORDPRESS_ADMIN_EMAIL}\n")
    env_file.write(f"MYSQL_ROOT_PASSWORD={MYSQL_ROOT_PASSWORD}\n\n")
    # Redis
    env_file.write(f"# Redis\n")
    env_file.write(f"REDIS_HOST={REDIS_CONTAINER_NAME}\n")
    env_file.write(f"REDIS_PORT=6379\n")
    # FTP
    env_file.write(f"# FTP\n")
    env_file.write(f"FTP_USER={FTP_USER}\n")
    env_file.write(f"FTP_PASSWORD={FTP_PASSWORD}\n")

print(".env file has been created successfully. please copy it to docker-compose.yml directory")