#!/bin/bash


function buildAndPushContainer() {
    REGISTRY=$1
    LABEL=$2
    DIRECTORY=$3
    
    docker build -t ${LABEL} ${DIRECTORY}

    docker tag -f ${LABEL}/ ${REGISTRY}/${LABEL}

    docker push ${REGISTRY}/${LABEL}

}

WD=`pwd`
DOCKER_REGISTRY=$1

for distro in mesospherejenkins; do
    buildAndPushContainer ${DOCKER_REGISTRY} "arangodb/$distro" $distro
done
