include config.mk


UID=$(shell id -u)
UIG=$(shell id -g)

# HELP
# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help


start-server: ## Start local dev server
	sudo docker-compose up -d && \
	sleep 15 && \
	sudo docker-compose logs

stop-server: ## Stop dev server
	sudo docker-compose down

# vault status
status:
	sudo docker run --rm \
		--cap-add IPC_LOCK \
		-e VAULT_ADDR=$(VAULT_ADDR) \
		vault \
		status

vault: ## vault CLI
	sudo docker run --rm \
		--cap-add IPC_LOCK \
		-e VAULT_ADDR=$(VAULT_ADDR) \
		-e VAULT_TOKEN=$(VAULT_TOKEN) \
		-v $(PWD):/src/ \
		vault \
		$(filter-out $@,$(MAKECMDGOALS))