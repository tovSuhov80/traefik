# include .env
# export

all: cp-env cp-config touch-acme re-create

install: cp-env cp-config touch-acme build up

cp-env:
	@test -f .env || cp .env.dist .env

touch-acme:
	@test -f ./letsencrypt/acme.json || touch ./letsencrypt/acme.json && chmod 0600 ./letsencrypt/acme.json

cp-config:
	@test -f ./config/traefik.yml || cp ./config/traefik.yml.dist ./config/traefik.yml

build:
	@docker network create web

up:
	@docker-compose up -d --build --remove-orphans

env:
	@docker-compose exec --user=www-data traefik bash

env-root:
	@docker-compose exec traefik bash

down:
	@docker-compose down

down-v:
	@docker-compose down -v

stop:
	@docker-compose stop

restart:
	@docker-compose restart

re-create:
	@docker-compose up -d --build --remove-orphans --force-recreate

logs:
	@docker-compose logs -f --tail=100

logs-all:
	@docker-compose logs -f
