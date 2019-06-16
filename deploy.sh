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
docker run -it --rm \
  -e COVERALLS_REPO_TOKEN="$COVERALLS_REPO_TOKEN" \
  -e CI_NAME="Travis ci build #: $TRAVIS_BUILD_ID" \
  -e CI_BUILD_URL="$TRAVIS_BUILD_WEB_UR" \
  -e CI_BRANCH="$TRAVIS_BRANCH" \
  -e CI_BUILD_NUMBER="$TRAVIS_BUILD_ID"
  jtwebman/node-express-docker-starter:dev npm run coveralls