SRC_DIR := srcs
ENV_FILE := $(SRC_DIR)/.env
DOCKER_COMPOSE := docker-compose -f $(SRC_DIR)/docker-compose.yml --env-file=$(ENV_FILE)

# make without args
.DEFAULT_GOAL := help

help:
	@echo "Usage: make <target>"
	@echo ""
	@echo "Available targets:"
	@echo "  build          Build Docker containers"
	@echo "  up          Start Docker containers"
	@echo "  down           Stop Docker containers"
	@echo "  restart        Restart Docker containers"
	@echo "  logs           View logs of Docker containers"
	@echo "  clean          Remove Docker containers and volumes"
	@echo "  help           Display this help message"


build:
	$(DOCKER_COMPOSE) build

up:
	$(DOCKER_COMPOSE) up -d

down:
	$(DOCKER_COMPOSE) down

restart: stop start

logs:
	$(DOCKER_COMPOSE) logs -f

clean:
	$(DOCKER_COMPOSE) down -v

clean_cache:
	docker system prune -af

