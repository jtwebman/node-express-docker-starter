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
  -e COVERALLS_SERVICE_NAME="Travis-ci" \
  -e COVERALLS_GIT_COMMIT="$TRAVIS_COMMIT" \
  -e COVERALLS_GIT_BRANCH="$TRAVIS_BRANCH" \
  -e COVERALLS_SERVICE_JOB_ID="$TRAVIS_JOB_ID" \
  jtwebman/node-express-docker-starter:dev npm run coveralls