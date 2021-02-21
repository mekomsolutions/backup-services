#!/bin/bash

Services=filestore_backup,mysql_backup,postgres_backup

echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

for service in ${Services//,/ }
do
    echo "Building $service $TRAVIS_CPU_ARCH image"
    docker build ${service}/ -t $DOCKER_USERNAME/${service}:$(git rev-parse --short HEAD)_$TRAVIS_CPU_ARCH
    echo "Pushing $service $TRAVIS_CPU_ARCH image"
    docker push $DOCKER_USERNAME/${service}:$(git rev-parse --short HEAD)_$TRAVIS_CPU_ARCH
done
