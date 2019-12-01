# versioning
GIT_HASH = $(shell git rev-parse HEAD | cut -c -8)

.PHONY: all
all: build push

.PHONY: build
build:
	@docker build --tag=devinalvaro/base:$(GIT_HASH) .
	@docker tag devinalvaro/base:$(GIT_HASH) devinalvaro/base:latest

.PHONY: push
push:
	@docker push devinalvaro/base:$(GIT_HASH)
	@docker push devinalvaro/base:latest
