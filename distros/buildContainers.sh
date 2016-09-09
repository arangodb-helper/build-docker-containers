#!/bin/bash


function buildAndPushContainer() {
    REGISTRY=$1
    LABEL=$2
    DIRECTORY=$3
    BUILDNRUN=$4
    
    docker build -t ${LABEL}/${BUILDNRUN} https://github.com/arangodb-helper/build-docker-containers.git#master:distros/${DIRECTORY}/${BUILDNRUN}

    docker tag -f ${LABEL}/${BUILDNRUN} ${REGISTRY}/${LABEL}/${BUILDNRUN}


    docker push ${REGISTRY}/${LABEL}/${BUILDNRUN}

}

WD=`pwd`

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
        buildAndPushContainer $1 ${LABEL} "$distro/$distroversion" build
        buildAndPushContainer $1 ${LABEL} "$distro/$distroversion" run
    done
done
