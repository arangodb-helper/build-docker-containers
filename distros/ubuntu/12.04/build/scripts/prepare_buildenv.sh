#!/bin/sh

CC="/opt/arangodb/bin/gcc"
CXX="/opt/arangodb/bin/g++"

CONFIGURE_OPTIONS="-DDISABLE_XZ_DEB=true ${CONFIGURE_OPTIONS}"
