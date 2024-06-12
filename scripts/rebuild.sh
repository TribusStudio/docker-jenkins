#!/bin/bash
# Rebuild script
# This is meant to be run on a regular basis to make sure everything works with
# the latest version of scripts.

set -e

CREDENTIALS="$HOME/.tribus-docker-credentials.sh"

if [ ! -f "$CREDENTIALS" ]; then
  echo "Please create $CREDENTIALS and add to it:"
  echo "DOCKERHUB=hub.tribus.studio"
  echo "DOCKERHUBUSER=xxx"
  echo "DOCKERHUBPASS=xxx"
  exit;
else
  source "$CREDENTIALS";
fi

./test.sh

PROJECT=jenkins
DATE=`date '+%Y-%m-%d-%H-%M-%S-%Z'`
MAJORVERSION='1'
VERSION='1.0'

# Start by getting the latest version of the official node image
docker pull node

# See https://github.com/TribusStudio/prepare-docker-buildx, for M1 native images.
git clone https://github.com/TribusStudio/prepare-docker-buildx.git
cd prepare-docker-buildx
export DOCKER_CLI_EXPERIMENTAL=enabled
./scripts/run.sh
cd ..

docker buildx create --name tsbuilder
docker buildx use tsbuilder
docker buildx inspect --bootstrap
docker login "$DOCKERHUB" -u"$DOCKERHUBUSER" -p"$DOCKERHUBPASS"

docker buildx build -t "$DOCKERHUB"/"$PROJECT":"$VERSION" --platform linux/amd64,linux/arm64/v8 --push .
docker buildx build -t "$DOCKERHUB"/"$PROJECT":"$MAJORVERSION" --platform linux/amd64,linux/arm64/v8 --push .
docker buildx build -t "$DOCKERHUB"/"$PROJECT":"$MAJORVERSION".$DATE --platform linux/amd64,linux/arm64/v8 --push .
docker buildx build -t "$DOCKERHUB"/"$PROJECT":"$VERSION".$DATE --platform linux/amd64,linux/arm64/v8 --push .
