This is the docker image to build the arangodb documentation.

To update the public available image run:

    docker tag 192.168.0.1/debianjessiedocu/build arangodb/documentation-builder
    docker push arangodb/documentation-builder

On the Jenkins hosts the docker image needs to be available under another tag: 

    docker tag 192.168.0.1/debianjessiedocu/build 192.168.0.1/arangodb/documentation-builder
    docker push 192.168.0.1/arangodb/documentation-builder 
