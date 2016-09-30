#!/bin/bash

echo "Unshallowing repo"
git fetch --unshallow
git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
git fetch origin

echo "Creating env file"
echo "export GIT_CHANGES=\$(git diff --name-only origin/master..HEAD)" >> .env
