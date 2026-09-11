DOCKER = docker
IMAGE = ghcr.io/seravo/phpcs:latest
APT_PROXY ?=

all:

build:
	$(DOCKER) build --build-arg APT_PROXY="$(APT_PROXY)" -t $(IMAGE) .

run:
	$(DOCKER) run --rm -it $(IMAGE) --help

run-cli:
	$(DOCKER) run --rm -it --entrypoint bash $(IMAGE)
