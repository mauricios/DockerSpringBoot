build: recreate ?= 
build:
	docker-compose up -d --build --remove-orphans $(recreate) $(container)

remove: ## Remove containers
	docker-compose rm --force --stop $(container)

reload up: ## Reload one or all containers 
	docker-compose up -d $(container)

down: 
	docker-compose down $(container)

stop:
	docker-compose stop $(container)

start:
	docker-compose start $(container)

restart:
	docker-compose restart $(container)

rebuild: | down build ## Rebuild containers

reboot: | remove up ## Recreate containers

status ps:
	docker-compose ps $(container)

cli exec: container ?= app
cli exec: bash ?= ash
cli exec: ## Execute commands in containers, use "command"  argument to send the command. By Default enter the shell.
	docker-compose exec $(container) $(bash) $(command)

run: container ?= app
run: bash ?= ash
run: ## Run commands in a new container
	docker-compose run --rm $(container) $(bash) $(command)

config:
	docker-compose config

logs: container ?= app
logs: ## Show logs. Usage: make logs [container=app]
	docker-compose logs -f $(container)

copy: container ?= app
copy: ## Copy app files/directories from container to host
	docker cp $(shell docker-compose ps -q $(container)):$(path) .

open: ## Open app in the browser
	open $(subst 0.0.0.0,localhost,http://$(shell docker-compose port app 8080))/greeting

expose: ## Expose your local environment to the internet, thanks to Serveo (https://serveo.net)
	ssh -R 80:localhost:$(subst 0.0.0.0:,,$(shell docker-compose port app 8080)) serveo.net

h help: ## This help.
	@echo 'Usage: make <task>'
	@echo 'Default task: build'
	@echo
	@echo 'Tasks:'
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9., _-]+:.*?## / {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := build
.PHONY: all	