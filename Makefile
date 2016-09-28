GIT_CHANGES := $(shell git diff-tree --no-commit-id --name-only -r $(shell git rev-parse HEAD) | cut -d/ -f1 | grep -v '.travs.yml')

all: build

build:	## Build the necessary elements for the project
	@if [[ "$(GIT_CHANGES)" == *"Dockerfile"* ]]; then \
		echo "Dockerfile changes detected, testing docker build"; \
		docker build \
		--build-arg VCS_REF=`git rev-parse --short HEAD` \
		--build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` .; \
	fi

list_changes:	## List all files that have commited changes
	@echo $(GIT_CHANGES)
