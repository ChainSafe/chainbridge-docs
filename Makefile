PROJECTNAME=$(shell basename "$(PWD)")
 

.PHONY: help run build install license
all: help


build-mkdocs:
	docker run --rm -it -v ${PWD}:/docs squidfunk/mkdocs-material build

mkdocs:
	docker run --rm -it -p 8000:8000 -v ${PWD}:/docs squidfunk/mkdocs-material



