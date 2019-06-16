#!/bin/bash
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
PACKAGE_VERSION=$(cat package.json \
  | grep version \
  | head -1 \
  | awk -F: '{ print $2 }' \
  | sed 's/[",]//g')

docker tag jtwebman/node-express-docker-starter jtwebman/node-express-docker-starter:$PACKAGE_VERSION
docker push jtwebman/node-express-docker-starter:latest
docker push jtwebman/node-express-docker-starter:$PACKAGE_VERSION