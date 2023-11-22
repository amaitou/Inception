path = ./srcs/docker-compose.yaml

YELLOW := \033[1;33m
GREEN := \033[1;32m
RED := \033[1;31m
LIGHT_GREEN := \033[1;92m
RESET := \033[0m

all: build up_detach

build:
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

show:
	@echo "$(GREEN)[.] List of all running containers$(RESET)"
	@sudo docker container ls

show_all:
	@echo "$(GREEN)[.] List all running and sleeping containers$(RESET)"
	@sudo docker container ls -a

fclean: remove_containers remove_images

re: fclean build up_detach

.PHONY: all down build down up up_detach remove_images remove_containers stop fclean re show show_all
