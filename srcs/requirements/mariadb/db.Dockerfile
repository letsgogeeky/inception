FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y \
    mariadb-server \
    tini && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# ARG for cache busting
ARG CACHEBUST=1
# ENV for mariadb
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY ./tools/init.sql /docker-entrypoint-initdb.d/init.sql
COPY ./tools/init.sh /docker-entrypoint-initdb.d/init.sh

RUN chmod +x /docker-entrypoint-initdb.d/init.sh

RUN mkdir -p /run/mysqld

# EXPOSE 3306

ENTRYPOINT [ "/usr/bin/tini", "--" ]

CMD ["/bin/bash", "-c", "/docker-entrypoint-initdb.d/init.sh && mysqld"]