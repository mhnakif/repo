IMAGE ?= mhnakif/repo
TAG ?= latest
DOCKER_CONFIG ?= $(CURDIR)/.docker

.PHONY: login build push

login:
	@printf "Docker PAT: " ; \
	read -s PASS ; echo ; \
	if [ -z "$$PASS" ]; then echo "Missing PAT"; exit 1; fi; \
	printf "%s" "$$PASS" | DOCKER_CONFIG=$(DOCKER_CONFIG) docker login -u mhnakif --password-stdin

build:
	DOCKER_CONFIG=$(DOCKER_CONFIG) docker build -t $(IMAGE):$(TAG) .

push: build
	DOCKER_CONFIG=$(DOCKER_CONFIG) docker push $(IMAGE):$(TAG)
