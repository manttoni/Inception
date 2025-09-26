all:
	make up

up:
	mkdir -p /home/amaula/data/mariadb_volume
	sudo chown -R 100:101 /home/amaula/data/mariadb_volume
	mkdir -p /home/amaula/data/wordpress_volume
	docker compose -f srcs/docker-compose.yml up --build

down:
	docker compose -f srcs/docker-compose.yml down

clean:
	docker compose -f srcs/docker-compose.yml down --volumes --rmi all
	sudo rm -rf /home/amaula/data

fclean: clean

re: fclean
	make all

.PHONY: all up down clean fclean re
