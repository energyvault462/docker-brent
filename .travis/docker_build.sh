#!/bin/bash

source .env

if [ "$DEBUG" == "true" ]; then
	echo "Debug enabled"
fi

if [[ "$GIT_CHANGES" == *"Dockerfile"* || "$DEBUG" == "true" ]]; then
	echo "Dockerfile changes detected"

	BUILD_DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
	BUILD_NUMBER=$TRAVIS_BUILD_NUMBER
	IMAGE_VERSION="0.0.1"

	echo "Testing Dockerfile"
	echo "		Name: $IMAGE_NAME"
	echo "		Build Date: $BUILD_DATE"
	echo "		Build Number: $BUILD_NUMBER"
	echo "		Image Version: $IMAGE_VERSION"

	docker pull $IMAGE_NAME
	docker build \
		-t $IMAGE_NAME \
		--build-arg BUILD_DATE=$BUILD_DATE \
		--build-arg BUILD_NUMBER=$BUILD_NUMBER \
		--build-arg VERSION=$IMAGE_VERSION \
		.

	echo "Testing Docker Image"
	RESULT="$(docker run -it --rm $IMAGE_NAME whoami)"
	EXPECTED="brent"
	[[ "$RESULT" == *"$EXPECTED"* ]] || echo "Failed -- Got: $RESULT Expected: $EXPECTED"

else
	echo "No Dockerfile changes, skipping docker build"
fi
