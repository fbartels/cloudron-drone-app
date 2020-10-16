CLOUDRON_APP ?= drone
CLOUDRON_ID := $(shell jq -r .id CloudronManifest.json)
CLOUDRON_SERVER ?= my.9wd.eu
CLOUDRON_TOKEN ?=123
DOCKER_REPO ?= fbartels

.PHONY: default
default: build update

.PHONY: init
init:
	cloudron init

.PHONY: build
build:
	cloudron build --set-repository $(DOCKER_REPO)/$(CLOUDRON_ID)

.PHONY: update
update: build
	cloudron update --app ${CLOUDRON_APP}

.PHONY: update-ci
update-ci:
	cloudron update --server ${CLOUDRON_SERVER} --token ${CLOUDRON_TOKEN} --app ${CLOUDRON_APP}

.PHONY: install
install: build
	cloudron install --location ${CLOUDRON_APP}

.PHONY: uninstall
uninstall:
	cloudron uninstall --app ${CLOUDRON_APP}

.PHONY: install-debug
install-debug:
	cloudron install --location ${CLOUDRON_APP} --debug

.PHONY: exec
exec:
	cloudron exec --app ${CLOUDRON_APP}

.PHONY: logs
logs:
	cloudron logs -f --app ${CLOUDRON_APP}
