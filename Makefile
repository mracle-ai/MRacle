# Oneshell means one can run multiple lines in a recipe in the same shell, so one doesn't have to
# chain commands together with semicolon
.ONESHELL:
SHELL=/bin/bash
ROOT_DIR=mracle
PACKAGE=src/mracle
PACKAGE_NAME=mracle
PYTHON = python
PYTHON_VERSION=3.11
DOCKER_IMAGE=mracle-dev

# If .env file exists, include it and export its variables
ifeq ($(shell test -f .env && echo 1),1)
    include .env
    export
endif

update-pip:
	${PYTHON} -m pip install -U pip

install-base: ## Installs only package dependencies
	rye sync --no-dev --no-lock

install-lint:
	pip install ruff==0.5.4

lint: ## Lint code with ruff
	${PYTHON} -m ruff format ${PACKAGE} --check --diff
	${PYTHON} -m ruff check ${PACKAGE}

docker-build: ## Build docker image
	docker compose build ${DOCKER_IMAGE}

docker-run: ## Run docker image
	docker compose up -d ${DOCKER_IMAGE}

docker-down: ## Stop and remove docker containers
	docker compose down --remove-orphans

local-run:
	uvicorn src.mracle.app:create_app --host 0.0.0.0 --port ${DEV_DEPLOYMENT_PORT} --reload --factory --log-config ${DATA_DIR}/${LOG_CONFIG_PATH}
