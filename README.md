## A highly configurable intrastructure

### A note about Dockerfile names:
For every service described in a dockerfile, their Dockerfile is named in this pattern `<service>.Dockerfile` ex: [nginx.Dockerfile](srcs/requirements/nginx/nginx.Dockerfile) or [ftp.Dockerfile](srcs/requirements/bonus/ftp/ftp.Dockerfile), the main reason I take this naming convention is to enhance developer experience. having multiple open Dockerfiles in your code editor feels less tedious when the file name describes what's inside of it.

### Services documentations
- [Nginx](docs/Nginx.md)
- [MariaDB](docs/Mariadb.md)
- [Prometheus](docs/Prometheus.md)

### A few reminders for the wandering minds:

- When pruning the environment, remember to also remove volumes from the docker volumes.
- Both Docker images and Docker containers will end up having the same name, it's okay for now.
- I found naming Dockerfiles in this format `<service>.Dockerfile` to have a better developer experience when navigating and opening multiple dockerfiles at the same time on an editor.
- When Docker raises a `no such file or directory` for volumes, try restarting Docker, yes, apparently restarting Docker solves the issue!!!!!!!
- ALWAYS REMEMBER TO REMOVE VOLUMES WHEN THINGS GO WRONG WITH DB CONFIG, OTHERWISE YOU WILL KEEP GETTING THE SAME RESULTS WITHOUT KNOWING WHAT'S GOING ON!

### Generate .env file or use env_template:
Simply use `genenv.py` script and follow along, most of the fields has default values except passwords.
```bash
python genenv.py
```
OR
Modify env_template file on root directory to include your preferred values.


### Working with Maria db:
- Connecting to mariadb from it's own container
    `mysql -u root -p${MYSQL_ROOT_PASSWORD}`
- Exploring DB users to make sure they are configured properly
```sql
SHOW DATABASES; /* apparently, shows all databases. */
SELECT user, host FROM mysql.user;
```

- Connecting to mariadb from another container:

`mysql -h inception-mariadb -u $WORDPRESS_DB_USER -P 3306 -p`


## TODO:
- write a script to detect the version of php-fpm and pass it to CMD in dockerfile
- wirte a script to generate nginx config instead of the static one to replace with env variables.
