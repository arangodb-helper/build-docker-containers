#!/bin/bash


function buildAndPushContainer() {
    REGISTRY=$1
    LABEL=$2
    DIRECTORY=$3
    BUILDNRUN=$4

    #docker build -t ${LABEL}/${BUILDNRUN} https://github.com/arangodb-helper/build-docker-containers.git#master:distros/${DIRECTORY}/${BUILDNRUN}
    docker build -t ${LABEL}/${BUILDNRUN} ${WD}/${DIRECTORY}/${BUILDNRUN}

    docker tag -f ${LABEL}/${BUILDNRUN} ${REGISTRY}/${LABEL}/${BUILDNRUN}

    docker push ${REGISTRY}/${LABEL}/${BUILDNRUN}

}

WD=`pwd`
DOCKER_REGISTRY=$1
LABEL_FILTER=$2

for distro in *; do
    if test "$distro" == '.' -o "$distro" == '..' -o "$distro" == "buildContainers.sh"; then
        continue;
    fi

    cd $WD/$distro
    for distroversion in *; do 
        if test "$distro" == '.' -o "$distro" == '..'; then
            continue
        fi
        LABEL=`cat $WD/$distro/$distroversion/LABEL`
        if test -n "$LABEL_FILTER" -a "$LABEL_FILTER" != "${LABEL}"; then
           echo "skipping ${LABEL}"
           continue
        fi
        buildAndPushContainer ${DOCKER_REGISTRY} ${LABEL} "$distro/$distroversion" build
        buildAndPushContainer ${DOCKER_REGISTRY} ${LABEL} "$distro/$distroversion" run
    done
done
