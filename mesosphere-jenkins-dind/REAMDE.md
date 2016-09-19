No-DIND
-------

Messosphere will by default run a docker container that can start sub-dockers.
While this may provide better abstraction from the host system, these instances
are dropped, and their docker is dropped with it too.
=> images have to be pulled again, instead of using the pull from the last time.

Therefore we discard this approach, but instead give the docker utilities in this
container access to the parrent container. This reduces the resource usage on deploy.
