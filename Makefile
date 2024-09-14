ifneq (,$(wildcard ./srcs/.env))
	include srcs/.env
	export
endif

DATA = ~/data/inception
COMPOSE_FILE := ./srcs/docker-compose.yml

start: $(DATA)
	docker-compose -f ${COMPOSE_FILE} up -d --build

stop:
	docker-compose -f ${COMPOSE_FILE} down

ssh-nginx:
	docker exec -it ${NGINX_CONTAINER_NAME} bash

ssh-db:
	docker exec -it ${DB_CONTAINER_NAME} bash

ssh-wp:
	docker exec -it ${WP_CONTAINER_NAME} bash

re: stop start

$(DATA):
	mkdir -p $(DATA)
	mkdir -p $(DATA)/www
	mkdir -p $(DATA)/db