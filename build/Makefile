# defaults
IMAGE_NAME = devinalvaro/base

# versioning
GIT_HASH = $(shell git rev-parse HEAD | cut -c -8)

.PHONY: all
all: build push

.PHONY: build
build:
	@docker build --tag=$(IMAGE_NAME):$(GIT_HASH) .
	@docker tag $(IMAGE_NAME):$(GIT_HASH) $(IMAGE_NAME):latest

.PHONY: push
push:
	@docker push $(IMAGE_NAME):$(GIT_HASH)
	@docker push $(IMAGE_NAME):latest
