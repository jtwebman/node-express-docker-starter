#!/bin/bash

# Get node.js package version
PACKAGE_VERSION=$(grep '"version":' package.json | cut -d\" -f4)

docker build -t jtwebman/node-express-docker-starter:dev --target=development .
docker build -t jtwebman/node-express-docker-starter .
docker tag jtwebman/node-express-docker-starter "jtwebman/node-express-docker-starter:$PACKAGE_VERSION"
docker push jtwebman/node-express-docker-starter:latest
docker push "jtwebman/node-express-docker-starter:$PACKAGE_VERSION"
docker push jtwebman/node-express-docker-starter:dev