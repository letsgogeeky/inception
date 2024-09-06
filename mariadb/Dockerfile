FROM debian:stable

# Install MariaDB
RUN apt-get update && apt-get install -y mariadb-server

# Copy the MariaDB configuration file
COPY my.cnf /etc/mysql/my.cnf

# Expose the default MariaDB port
EXPOSE 3306

# Start the MariaDB service
CMD ["mysqld"]