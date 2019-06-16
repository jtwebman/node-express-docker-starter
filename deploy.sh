#!/bin/bash

# Get node.js package version
PACKAGE_VERSION=$(grep '"version":' package.json | cut -d\" -f4)

# Login to docker hub and push latest, development, and version tags
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
docker tag jtwebman/node-express-docker-starter "jtwebman/node-express-docker-starter:$PACKAGE_VERSION"
docker push jtwebman/node-express-docker-starter:latest
docker push "jtwebman/node-express-docker-starter:$PACKAGE_VERSION"
docker push jtwebman/node-express-docker-starter:dev

# Run coverall to push coverage reports
docker run -it --rm -e TRAVIS_JOB_ID="$TRAVIS_JOB_ID" -e TRAVIS_BRANCH="$TRAVIS_BRANCH" jtwebman/node-express-docker-starter:dev bash -c "npm i && npm run coveralls"