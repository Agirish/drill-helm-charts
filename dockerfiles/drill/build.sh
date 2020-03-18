#!/bin/bash

PROJECT=drill
VERSION=$1

if [[ ${VERSION} == "" ]]
then
  echo "Please enter the Drill VERSION string. For ex: 1.17.0"
  exit -1
fi

docker build --build-arg VERSION=${VERSION} -t ${PROJECT}:${VERSION} .

if [[ $? -eq 0 ]]
then
  docker tag ${PROJECT}:${VERSION} agirish/${PROJECT}:${VERSION}
  docker push agirish/${PROJECT}:${VERSION}
fi