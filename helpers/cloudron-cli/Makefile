DOCKER_REPO ?= fbartels
DOCKER_IMAGE := cloudron-cli
VERSION := $(shell grep cloudron@ Dockerfile | cut -d' ' -f 5 | cut -d@ -f 2)

.PHONY: default
default: push

.PHONY: build
build:
	docker build . -t $(DOCKER_IMAGE)

.PHONY: tag
tag: build
	docker tag $(DOCKER_IMAGE) $(DOCKER_REPO)/$(DOCKER_IMAGE):latest
	docker tag $(DOCKER_IMAGE) $(DOCKER_REPO)/$(DOCKER_IMAGE):$(VERSION)

.PHONY: push
push: tag
	docker push $(DOCKER_REPO)/$(DOCKER_IMAGE):latest
	docker push $(DOCKER_REPO)/$(DOCKER_IMAGE):$(VERSION)
