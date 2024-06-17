DOCKER = docker
IMAGE = ghcr.io/seravo/phpcs:latest

all:

build:
	$(DOCKER) build -t $(IMAGE) .

run:
	$(DOCKER) run --rm -it $(IMAGE)

