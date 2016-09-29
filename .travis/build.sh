#!/bin/bash
GIT_CHANGES=$(git diff --name-only $TRAVIS_COMMIT_RANGE)

echo "Files Changes: $GIT_CHANGES"

if [[ "$GIT_CHANGES" == *"Dockerfile"* ]]; then
	echo "Dockerfile changes detected, testing docker build"
	docker build \
		--build-arg VCS_REF=`git rev-parse --short HEAD` \
		--build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
		.
fi
