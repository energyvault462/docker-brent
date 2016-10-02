#!/bin/bash

source .env

if [[ "$GIT_CHANGES" == *"Dockerfile"* || "$DUBUG" == "true" ]]; then
	echo "Dockerfile changes detected\n"

	BUILD_DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
	BUILD_NUMBER=$TRAVIS_BUILD_NUMBER
	IMAGE_VERSION="0.0.1"

	echo "Testing Dockerfile"
	echo "\tName: $IMAGE_NAME"
	echo "\tBuild Date: $BUILD_DATE"
	echo "\tBuild Number: $BUILD_NUMBER"
	echo "\tImage Version: $IMAGE_VERSION"

	docker build \
		-t $IMAGE_NAME
		--build-arg BUILD_DATE=$BUILD_DATE \
		--build-arg BUILD_NUMBER=$BUILD_NUMBER \
		--build-arg VERSION=$IMAGE_VERSION \
		.

	echo "Testing Docker Image"
	[ "$(docker run -it --rm $IMAGE_NAME whomai)" == "dan9186" ]

else
	echo "No Dockerfile changes, skipping docker build"
fi
