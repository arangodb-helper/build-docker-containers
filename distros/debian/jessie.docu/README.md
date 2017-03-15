This is the docker image to build the arangodb documentation.

To update the public available image run:

    docker tag 192.168.0.1/debianjessiedocu/build arangodb/documentation-builder
    docker push arangodb/documentation-builder
