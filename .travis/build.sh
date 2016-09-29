#!/bin/bash
git fetch --unshallow
git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
git fetch origin

GIT_CHANGES=$(git diff --name-only origin/master..HEAD)
echo "Files Changes: $GIT_CHANGES"

if [[ "$GIT_CHANGES" == *"Dockerfile"* ]]; then
	echo "Dockerfile changes detected, testing docker build"
	docker build \
		--build-arg VCS_REF=`git rev-parse --short HEAD` \
		--build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
		.
else
	echo "No Dockerfile changes, skipping docker build"
fi
