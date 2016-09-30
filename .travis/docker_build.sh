#!/bin/bash

source .env

if [[ "$GIT_CHANGES" == *"Dockerfile"* ]]; then
	echo "Dockerfile changes detected, testing docker build"
	docker build \
		--build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
		--build-arg BUILD_NUMBER=$TRAVIS_BUILD_NUMBER \
		--build-arg VERSION="0.0.1" \
		.
else
	echo "No Dockerfile changes, skipping docker build"
fi
