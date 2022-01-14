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
		vault \
		$(filter-out $@,$(MAKECMDGOALS))

# # Build the container
# build-backend: ## Compila imagen del backend
# 	sudo docker pull $(REGISTRY_IMAGE)/backend:builder || true
# 	sudo docker pull $(REGISTRY_IMAGE)/backend:latest || true
# 	sudo docker build \
# 		--target build \
# 		--cache-from $(REGISTRY_IMAGE)/backend:builder \
# 		-t $(REGISTRY_IMAGE)/backend:builder \
# 		-f ./backend/src/HHRRMobile/Dockerfile \
# 		./backend/src
# 	sudo docker build \
# 		--cache-from $(REGISTRY_IMAGE)/backend:builder \
# 		--cache-from $(REGISTRY_IMAGE)/backend:latest \
# 		-t $(REGISTRY_IMAGE)/backend:latest \
# 		-f ./backend/src/HHRRMobile/Dockerfile \
# 		./backend/src

# publish-backend: 
# 	sudo docker push $(REGISTRY_IMAGE)/backend:builder
# 	sudo docker push $(REGISTRY_IMAGE)/backend:latest

# # Run backend
# run-backend: ## Ejecuta contenedor del backend
# 	sudo docker run --rm \
# 		-p $(BACKEND_LOCAL_PORT):80 \
# 		-v ${HOME}/.microsoft/usersecrets:/root/.microsoft/usersecrets:ro \
# 		-e ASPNETCORE_ENVIRONMENT=Development \
# 		--name $(BACKEND_CONTAINER_NAME) \
# 		$(REGISTRY_IMAGE)/backend:latest

# stop-backend: ## Detiene el contenedor del backend
# 	sudo docker stop $(BACKEND_CONTAINER_NAME) || true


# run-mock-backend: ## Levanta un backend mock, basado en la última definicion de openapi.json
# 	sudo docker run --init --rm \
# 		-v $(PWD):/tmp \
# 		-p 4010:4010 \
# 		stoplight/prism:4 \
# 		mock -h 0.0.0.0 "/tmp/src/openapi.json"

# run-frontend-dev: ## Ejecuta contenedor del frontend en modo desarrollo
# 	sudo docker run --rm -it  \
# 		--name disposable-ionic-dev  \
# 		-e PGID=${UID} -e PUID=${UIG} \
# 		-c 256 -m 1536m  \
# 		-p 8100:8100  \
# 		-p 35729:35729  \
# 		-v ${PWD}/src/frontend:/root/project  \
# 		registry.gitlab.octubre.org.ar/dev/ionic-builder:6.13  \
# 		serve --host 0.0.0.0

# stop-frontend-dev: ## Detiene contenedor del frontend
# 	sudo docker stop disposable-ionic-dev

# build-frontend-prod: ## Compila contenedor del frontend en modo produccion
# 	sudo docker run --rm -it  \
# 		-e PGID=${UID} -e PUID=${UIG} \
# 		-c 256 -m 1536m  \
# 		-v ${PWD}/src/frontend:/root/project  \
# 		registry.gitlab.octubre.org.ar/dev/ionic-builder:6.13  \
# 		build --prod

# copy-frontend-deps: ## Copia dependencias node desde una imagen del frontend (Recomendado)
# 	sudo docker pull ${REGISTRY_IMAGE}/frontend:builder \
# 		&& sudo docker create -ti --name disposable_rrhhapp_dev ${REGISTRY_IMAGE}/frontend:builder sh  \
# 		&& sudo docker cp disposable_rrhhapp_dev:/root/project/node_modules ${PWD}/frontend  \
# 		&& sudo docker rm -f disposable_rrhhapp_dev \
# 		&& sudo chown -R $USER frontend/node_modules

# install-frontend-deps: ## Instala dependencias node usando npm install
# 	sudo docker run --rm -it \
# 		--name disposable_node \
# 		--entrypoint npm \
# 		-e PGID=${UID} -e PUID=${UIG} \
# 		-c 256 -m 512m  \
# 		-w /home/node/ \
# 		-v ${PWD}/src/frontend:/home/node/ \
# 		node:12.18.2-alpine \
# 		install

# 		#--user ${UID}:${UIG} \

# npm: ## Ejecuta CLI de node
# 	sudo docker run --rm -it  \
# 		-w /app \
# 		-e PGID=${UID} -e PUID=${UIG} \
# 		-c 256 -m 1024m  \
# 		-v ${PWD}/src/frontend:/app  \
# 		node:12.18.2-alpine \
# 		$(filter-out $@,$(MAKECMDGOALS))

# ng: ## Ejecuta CLI de angular
# 	sudo docker run --rm -it  \
# 		-w /app \
# 		-e PGID=${UID} -e PUID=${UIG} \
# 		-c 256 -m 1024m  \
# 		-v ${PWD}/src/frontend:/app  \
# 		registry.gitlab.octubre.org.ar/dev/angular-cli:12.2 \
# 		$(filter-out $@,$(MAKECMDGOALS))

# ionic: ## Ejecuta CLI de ionic
# 	sudo docker run --rm -it  \
# 		-e PGID=${UID} -e PUID=${UIG} \
# 		-c 256 -m 1024m  \
# 		-v ${PWD}/src/frontend:/root/project  \
# 		registry.gitlab.octubre.org.ar/dev/ionic-builder:6.13 \
# 		$(filter-out $@,$(MAKECMDGOALS))