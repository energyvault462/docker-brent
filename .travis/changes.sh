#!/bin/bash

export GIT_CHANGES=$(git diff --name-only origin/master..HEAD)
echo "Files Changes: $GIT_CHANGES"
