Docker image for documentation building
=======================================

These are the files to generate the Docker image for building the
ArangoDB documentation.

The image comes with all required tools, like Node.js, Gitbook-CLI,
Calibre etc. and also includes offline copies of the Gitbook plugins for
every defined version of the documentation.

It is used in Jenkins for the jobs `PATCH_DOCUMENTATION` and
`RELEASE__BuildDocumentation`. Any changes to Gitbook plugins require a
rebuild of the image, as the books are built offline (without running
`gitbook install` which would fetch plugins online).

How to update
-------------

1. Connect to master/backup Jenkins via SSH as user `jenkins`

2. The files are checked out here:

       cd ~/build-docker-containers/distros/debian/jessie.docu

3. Update the working copy:

       git pull

4. Build the Docker image with invalidation of Gitbook plugins:

       docker build -t debianjessiedocu/build --build-arg CACHE_DATE=$(date --iso-8601=seconds) build

   Passing the current date and time ensures that the Gitbook plugins layer
   (and all subsequent layers) are re-generated. Without the `--build-arg`
   option, the cache would be used and the plugins wouldn't be re-downloaded
   unless something has changed in the Dockerfile in or above the `RUN`
   instruction which is responsible for downloading the Gitbook plugins.
   The `--no-cache` option on the other hand would cause a full rebuild of
   all layers, which is rarely needed.

5. _Optional:_ Inspect the content of the image to verify everything worked out:

       docker run -it debianjessiedocu/build /bin/bash

6. Tag the image (also for the deprecated local registry just in case):

       docker tag debianjessiedocu/build arangodb/documentation-builder
       docker tag arangodb/documentation-builder 192.168.0.1/arangodb/documentation-builder

7. Update the publicly available image on docker.io registry:

       docker push arangodb/documentation-builder

8. Update the other Jenkins:

       docker pull arangodb/documentation-builder
       docker tag arangodb/documentation-builder 192.168.0.1/arangodb/documentation-builder
       git pull
