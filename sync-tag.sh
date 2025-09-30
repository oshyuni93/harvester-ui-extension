#!/bin/bash
BRANCH="v1.5-head"
TAG="v1.5.2"

git checkout $BRANCH
git pull origin $BRANCH
git tag -f $TAG
git push origin $TAG --force
