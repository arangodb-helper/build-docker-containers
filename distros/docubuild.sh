#!/bin/bash

cd debian/jessie.docu

docker build -t debianjessiedocu/build build


docker tag debianjessiedocu/build arangodb/documentation-builder
docker tag debianjessiedocu/build arangodb/documentation-builder

docker push arangodb/documentation-builder

