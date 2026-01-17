IMAGE ?= mhnakif/repo
TAG ?= latest
DOCKER_CONFIG ?= $(CURDIR)/.docker

.PHONY: login build push

login:
	@echo "Use: echo $$DOCKER_PAT | docker login -u mhnakif --password-stdin"

build:
	DOCKER_CONFIG=$(DOCKER_CONFIG) docker build -t $(IMAGE):$(TAG) .

push: build
	DOCKER_CONFIG=$(DOCKER_CONFIG) docker push $(IMAGE):$(TAG)
