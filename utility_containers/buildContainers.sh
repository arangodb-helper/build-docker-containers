#!/bin/bash


function buildAndPushContainer() {
    REGISTRY=$1
    LABEL=$2
    DIRECTORY=$3
    BUILDNRUN=$4
    
    docker build -t ${LABEL}/${BUILDNRUN} 

    docker tag -f ${LABEL}/${BUILDNRUN} ${REGISTRY}/${LABEL}/${BUILDNRUN}


    docker push ${REGISTRY}/${LABEL}/${BUILDNRUN}

}

WD=`pwd`
DOCKER_REGISTRY=$1

for distro in mesospherejenkins; do
    buildAndPushContainer ${DOCKER_REGISTRY} $distro "arangodb/$distro" $distro
done
