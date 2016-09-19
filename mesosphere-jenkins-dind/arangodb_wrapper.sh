#!/bin/bash
set -e

echo "==> NOT!!! Launching the Docker daemon..."
# dind docker daemon --host=unix:///var/run/docker.sock --storage-driver=overlay $DOCKER_EXTRA_OPTS &

while(! docker info > /dev/null 2>&1); do
    echo "==> Waiting for the remote Docker daemon to come reachable..."
    sleep 1
done
echo "==> the hosts Docker Daemon is reachable!"

/bin/sh -c "$@"
