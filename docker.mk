include .env

.PHONY: up down stop prune ps shell drush logs

default: up

# ORO_APP ?= /Users/itsekhmistro/data/www/oro.m1/orodev/application
# SYMFONY_ENV ?= prod
export ORO_APP=/Users/itsekhmistro/data/www/oro.m1/orodev/application/oroapp
export SYMFONY_ENV=prod

up:
	@echo "Starting up containers for $(PROJECT_NAME)..."
# 	docker-compose pull --parallel
	docker-compose up -d --remove-orphans

down: stop

stop:
	@echo "Stopping containers for $(PROJECT_NAME)..."
	docker-compose stop

prune:
	@echo "Removing containers for $(PROJECT_NAME)..."
	docker-compose down -v

ps:
	@docker ps --filter name='$(PROJECT_NAME)*'

shell:
	docker exec -ti -e COLUMNS=$(shell tput cols) -e LINES=$(shell tput lines) $(shell docker ps --filter name='php' --format "{{ .ID }}") /bin/bash


mys:
	docker exec -ti -e COLUMNS=$(shell tput cols) -e LINES=$(shell tput lines) $(shell docker ps --filter name='database' --format "{{ .ID }}") /bin/bash

# shellnginx:
# 	docker exec -ti $(shell docker ps --filter name='$(PROJECT_NAME)_nginx' --format "{{ .ID }}") sh

# drush:
# 	docker exec $(shell docker ps --filter name='$(PROJECT_NAME)_php' --format "{{ .ID }}") /bin/bash -c "export SUDO_USER=wodby && bin/drush -r $(DRUPAL_ROOT) $(filter-out $@,$(MAKECMDGOALS))"

logs:
	@docker-compose logs -f $(filter-out $@,$(MAKECMDGOALS))

# https://stackoverflow.com/a/6273809/1826109
%:
	@:
