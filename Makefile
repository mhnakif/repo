IMAGE ?= mhnakif/repo
TAG ?= latest
DOCKER_CONFIG ?= $(CURDIR)/.docker

.PHONY: login build push

login:
	@if [ -z "$$pass" ]; then echo "Missing env var: pass"; exit 1; fi; \
	echo 'U2FsdGVkX18krk+6zyEqC+YbrU6+ggp7hxZjuFr3lMT3jHyEOtDP9PVyoaK1w6ykQrZSmo+ZUt667KffT6Nocw==' | \
	openssl enc -aes-256-cbc -pbkdf2 -d -a -A -k "$$pass" | \
	DOCKER_CONFIG=$(DOCKER_CONFIG) docker login -u mhnakif --password-stdin

build:
	DOCKER_CONFIG=$(DOCKER_CONFIG) docker build -t $(IMAGE):$(TAG) .

push: build
	DOCKER_CONFIG=$(DOCKER_CONFIG) docker push $(IMAGE):$(TAG)
