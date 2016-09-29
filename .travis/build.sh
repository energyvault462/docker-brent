#!/bin/bash
#GIT_CHANGES=$(git diff-tree --no-commit-id --name-only -r $(git rev-parse HEAD) | cut -d/ -f1 | grep -v '.travs.yml')
GIT_CHANGES=$(git diff --name-only HEAD $(git merge-base HEAD origin/master))

if [[ "$GIT_CHANGES" == *"Dockerfile"* ]]; then
	echo "Dockerfile changes detected, testing docker build"
	docker build \
		--build-arg VCS_REF=`git rev-parse --short HEAD` \
		--build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
		.
fi
