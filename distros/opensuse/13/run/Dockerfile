FROM opensuse:13.2
MAINTAINER Wilfried Goesgens <willi@arangodb.com>

# ARG HTTP_PROXY
# for local installation, uncomment
# ADD ./arangodb /install

COPY ./scripts/copyFileLockedIfNewer.py /usr/bin/

# add scripts to install the compiler toolchain
ADD ./scripts /scripts

RUN ls -l /scripts/
# install the build tools
RUN bash -x ./scripts/install.sh

# expose the build directory:
RUN mkdir -p /jenkins
VOLUME ["/jenkins"]

# expose shared storage:
RUN mkdir -p /net/fileserver
VOLUME ["/net/fileserver"]

# Opensuse doesn't provide /etc/issue so we create it...
RUN echo "openSuSE 13.1" > /etc/issue

