path = ./srcs/docker-compose.yaml

YELLOW := \033[1;33m
GREEN := \033[1;32m
RED := \033[1;31m
LIGHT_GREEN := \033[1;92m
RESET := \033[0m

all: build up_detach

create_wordpress:
	@if [ -d "/home/$(shell echo $$USER)/data/files" ]; then \
		echo "$(YELLOW)/home/$(shell echo $$USER)/data/files$(RESET) exists"; \
	else \
		echo "$(GREEN)Creating /home/$(shell echo $$USER)/data/files ...$(RESET)"; \
		sudo mkdir -p /home/$(shell echo $$USER)/data/files; \
	fi

create_mariadb:
	@if [ -d "/home/$(shell echo $$USER)/data/database" ]; then \
		echo "$(YELLOW)/home/$(shell echo $$USER)/data/database$(RESET) exists"; \
	else \
		echo "$(GREEN)Creating /home/$(shell echo $$USER)/data/database/ ...$(RESET)"; \
		sudo mkdir -p /home/$(shell echo $$USER)/data/database; \
	fi

create_both: create_wordpress create_mariadb

build: create_both
	@clear
	@echo "$(YELLOW)[*] Phase of building images ...$(RESET)"
	@sudo docker-compose -f $(path) build

down:
	@echo "$(RED)[-] Phase of stopping and deleting containers ...$(RESET)"
	@sudo docker-compose -f $(path) down -v

up:
	@echo "$(GREEN)[+] Phase of creating containers ...$(RESET)"
	@sudo docker-compose -f $(path) up

stop:
	@echo "$(RED)[!] Phase of stopping containers ...$(RESET)"
	@sudo docker-compose -f $(path) stop

up_detach:
	@echo "$(LIGHT_GREEN)[+] Phase of creating containers in detach mode ...$(RESET)"
	@sudo docker-compose -f $(path) up -d

remove_images:
	@echo "$(RED)[!] Deleting images ...$(RESET)"
	@sudo docker image rm -f $(shell sudo docker image ls -q)

remove_containers:
	@echo "$(RED)[!] Forcibly deleting containers ...$(RESET)"
	@sudo docker container rm -f $(shell sudo docker container ls -aq)

remove_volumes:
	@echo "$(RED)Removing volumes ...$(RESET)"
	@sudo rm -rf /home/$(shell echo $$USER)/data/database/ /home/$(shell echo $$USER)/data/files
	@sudo docker volume rm $(shell sudo docker volume ls -q)

remove_networks:
	@echo "$(RED) Removing networks ...$(RESET)"
	@sudo docker network rm inception

show:
	@echo "$(GREEN)[.] List of all running containers$(RESET)"
	@sudo docker container ls

show_all:
	@echo "$(GREEN)[.] List all running and sleeping containers$(RESET)"
	@sudo docker container ls -a
	@echo "$(GREEN)[.] List all images$(RESET)"
	@sudo docker image ls
	@echo "$(GREEN)[.] List all volumes$(RESET)"
	@sudo docker volume ls
	@echo "$(GREEN)[.] List all networks$(RESET)"
	@sudo docker network ls

fclean: remove_containers remove_images remove_volumes remove_networks

re: fclean build up_detach

.PHONY: all down build down up up_detach remove_images remove_containers stop fclean re show show_all
