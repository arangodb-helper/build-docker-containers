FROM alpine:3.4

RUN apk add --no-cache \
                ca-certificates \
                curl \
                openssl

ENV DOCKER_BUCKET get.docker.com
ENV DOCKER_VERSION 1.10.3
ENV DOCKER_SHA256 d0df512afa109006a450f41873634951e19ddabf8c7bd419caeb5a526032d86d

RUN curl -fSL "https://${DOCKER_BUCKET}/builds/Linux/x86_64/docker-$DOCKER_VERSION" -o /usr/local/bin/docker \
        && echo "${DOCKER_SHA256}  /usr/local/bin/docker" | sha256sum -c - \
        && chmod +x /usr/local/bin/docker

# COPY docker-entrypoint.sh /usr/local/bin/

# ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["sh"]
#################################################################################
# since DIND is not available in the version we need, ^^^ is copied from https://github.com/docker-library/docker
#################################################################################

MAINTAINER Mesosphere Support <support+jenkins-dind@mesosphere.com>

# http://bugs.python.org/issue19846
# > At the moment, setting "LANG=C" on a Linux system *fundamentally breaks Python 3*, and that's not OK.
ENV ALPINE_EDGE_COMMUNITY_REPO=http://dl-cdn.alpinelinux.org/alpine/edge/community \
    ALPINE_GLIBC_BASE_URL=https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.23-r2 \
    ALPINE_GLIBC_PACKAGE=glibc-2.23-r2.apk \
    ALPINE_GLIBC_BIN_PACKAGE=glibc-bin-2.23-r2.apk \
    ALPINE_GLIBC_I18N_PACKAGE=glibc-i18n-2.23-r2.apk \
    ALPINE_GLIBC_RSA_PUB_URL=https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.23-r2/sgerrand.rsa.pub \
    JAVA_HOME=/usr/lib/jvm/default-jvm \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    SSH_KNOWN_HOSTS=github.com

ENV PATH=${PATH}:${JAVA_HOME}/bin

# Please keep each package list in alphabetical order
RUN apk --update add \
    bash \
    bzip2 \
    ca-certificates \
    git \
    glib \
    jq \
    less \
    libsm \
    libstdc++ \
    make \
    openjdk8 \
    openssh-client \
    perl \
    py-pip \
    python \
    python3 \
    tar \
    unzip \
    && cd /tmp \
    && pip install --upgrade \
    pip \
    setuptools \
    virtualenv \
    wheel \
    && apk add --update --repository ${ALPINE_EDGE_COMMUNITY_REPO} tini \
    && wget -q -O /etc/apk/keys/sgerrand.rsa.pub "${ALPINE_GLIBC_RSA_PUB_URL}" \
    && wget -q "${ALPINE_GLIBC_BASE_URL}/${ALPINE_GLIBC_PACKAGE}" \
               "${ALPINE_GLIBC_BASE_URL}/${ALPINE_GLIBC_BIN_PACKAGE}" \
               "${ALPINE_GLIBC_BASE_URL}/${ALPINE_GLIBC_I18N_PACKAGE}" \
    && apk add ${ALPINE_GLIBC_PACKAGE} ${ALPINE_GLIBC_BIN_PACKAGE} ${ALPINE_GLIBC_I18N_PACKAGE} \
    && cd \
    && rm -rf /tmp/* /var/cache/apk/* \
    && /usr/glibc-compat/bin/localedef -i en_US -f UTF-8 en_US.UTF-8 \
    && echo 'export PATH=$PATH:${JAVA_HOME}/bin' >> /etc/profile.d/java.sh \
    && ssh-keyscan $SSH_KNOWN_HOSTS | tee /etc/ssh/ssh_known_hosts \
    && echo 'Done'

# COPY wrapper.sh /usr/local/bin/
# RUN chmod +x /usr/local/bin/wrapper.sh

ENTRYPOINT []
CMD []

#################################################################################
## ^^^^
# this is https://github.com/arangodb-helper/jenkins-dind-agent to add our own registry certificate.
# FROM mesosphere/jenkins-dind:0.3.1
#################################################################################

RUN mkdir -p /etc/docker/certs.d/192.168.0.1/
COPY domain.crt /etc/docker/certs.d/192.168.0.1/ca.crt

COPY arangodb_wrapper.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/arangodb_wrapper.sh
