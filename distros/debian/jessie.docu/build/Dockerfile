FROM node:7
MAINTAINER Wilfried Goesgens <willi@arangodb.com>

# ARG HTTP_PROXY
# for local installation, uncomment
# ADD ./arangodb /install

COPY ./scripts/copyFileLockedIfNewer.py /usr/bin/

# add scripts to install the compiler toolchain
ADD ./scripts /scripts

RUN ls -l /scripts/
# install the build tools by apt:
RUN bash -x ./scripts/install.sh
# install other stuff: 
RUN bash -x ./scripts/install_2.sh

# expose the build directory:
RUN mkdir -p /jenkins
VOLUME ["/jenkins"]

# expose shared storage:
RUN mkdir -p /net/fileserver
VOLUME ["/net/fileserver"]

