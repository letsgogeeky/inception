ifneq (,$(wildcard ./srcs/.env))
	include srcs/.env
	export
endif

DATA = ~/data/${PROJECT_NAME}
COMPOSE_FILE := ./srcs/docker-compose.yml

all: start

build:
	docker compose -f ${COMPOSE_FILE} build

build-nc:
	docker compose -f ${COMPOSE_FILE} build --no-cache

start: $(DATA) build
	docker compose -f ${COMPOSE_FILE} up -d

stop:
	docker compose -f ${COMPOSE_FILE} down

clean:
	docker compose -f ${COMPOSE_FILE} down -v
	rm -rf $(DATA)

fclean: clean
	docker rmi ${WP_CONTAINER_NAME} ${DB_CONTAINER_NAME} ${NGINX_CONTAINER_NAME} ${FTP_CONTAINER_NAME} ${REDIS_CONTAINER_NAME} \
		${GRAFANA_CONTAINER_NAME}
# docker volume rm srcs_mariadb_volume srcs_wordpress_volume

logs:
	docker compose -f ${COMPOSE_FILE} logs -f

ssh-nginx:
	docker exec -it ${NGINX_CONTAINER_NAME} bash

ssh-db:
	docker exec -it ${DB_CONTAINER_NAME} bash

ssh-wp:
	docker exec -it ${WP_CONTAINER_NAME} bash

ssh-redis:
	docker exec -it ${REDIS_CONTAINER_NAME} bash

ssh-ftp:
	docker exec -it ${FTP_CONTAINER_NAME} bash

re: stop start

$(DATA):
	mkdir -p $(DATA)
	mkdir -p $(DATA)/www
	mkdir -p $(DATA)/db
	mkdir -p $(DATA)/logs
	mkdir -p $(DATA)/cache
	mkdir -p $(DATA)/observe
	chmod 777 $(DATA)/www
	chmod 777 $(DATA)/db
	chmod 777 $(DATA)/logs
	chmod 777 $(DATA)/cache
	chmod 777 $(DATA)/observe

.PHONY: all build build-nc start stop clean fclean logs ssh-nginx ssh-db ssh-wp ssh-redis ssh-ftp re