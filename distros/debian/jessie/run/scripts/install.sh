#!/bin/sh
set -e

if test -n "${HTTP_PROXY}"; then
    echo "proxy=${HTTP_PROXY}" >> /etc/yum.conf
fi

# Unfuck debian container:
rm -f /usr/bin/chmod /usr/bin/chown

echo "proxy=${HTTP_PROXY}"
apt-get update
apt-get install -y \
        tar curl bzip2 \
        build-essential apt-utils apt-transport-https \
        git cmake automake autoconf \
        libjemalloc1 libldap-2.4-2 openssl \
        gdb \
        python-pip \
        ruby-httparty \
        ruby-multi-xml ruby-thread-safe rubygems-integration ruby-diff-lcs ri ruby-rgen


pip install lockfile

gem install bundler
curl -O https://raw.githubusercontent.com/arangodb/arangodb/devel/tests/rb/HttpInterface/Gemfile
bundle

useradd jenkins -u 1000

echo 'PATH=/opt/arangodb/bin/:${PATH}' >> /etc/bashrc
echo 'PATH=/opt/arangodb/bin/:${PATH}' >> /etc/profile
