DOCKER_REPO ?= fbartels
DOCKER_IMAGE := cloudron-surfer
VERSION := $(shell grep cloudron-surfer Dockerfile | cut -d' ' -f 5 | cut -d@ -f 2)

ifeq ($(shell command -v podman 2> /dev/null),)
    CMD=docker
else
    CMD=podman
endif

.PHONY: default
default: build

.PHONY: build
build:
	$(CMD) build . -t $(DOCKER_IMAGE)

.PHONY: tag
tag: build
	$(CMD) tag $(DOCKER_IMAGE) $(DOCKER_REPO)/$(DOCKER_IMAGE):latest
	$(CMD) tag $(DOCKER_IMAGE) $(DOCKER_REPO)/$(DOCKER_IMAGE):$(VERSION)

.PHONY: push
push: tag
	$(CMD) push $(DOCKER_REPO)/$(DOCKER_IMAGE):latest
	$(CMD) push $(DOCKER_REPO)/$(DOCKER_IMAGE):$(VERSION)

