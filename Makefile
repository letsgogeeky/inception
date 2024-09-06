DATA = ~/data

start: $(DATA)
	docker-compose up -d --build

stop:
	docker-compose down

$(DATA):
	mkdir -p $(DATA)
	mkdir -p $(DATA)/www
	mkdir -p $(DATA)/db