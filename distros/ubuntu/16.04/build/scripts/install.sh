#!/bin/sh
set -e

if test -n "${HTTP_PROXY}"; then
    echo "proxy=${HTTP_PROXY}" >> /etc/yum.conf
fi

echo "proxy=${HTTP_PROXY}"
apt-get update
apt-get install -y tar curl bzip2 git cmake automake autoconf python-argparse build-essential apt-utils apt-transport-https debhelper libjemalloc-dev libssl-dev python python-lockfile snapcraft libldap2-dev

cd /tmp/
curl -O http://download.opensuse.org/repositories/home:/fceller2/xUbuntu_14.04/Release.key
apt-key add - < Release.key
rm Release.key

echo 'deb http://download.opensuse.org/repositories/home:/fceller2/xUbuntu_14.04/ /' | tee /etc/apt/sources.list.d/arangodbbuild.list
apt-get update
apt-get install -y arangodb-gcc54

useradd jenkins -u 1000

echo 'PATH=/opt/arangodb/bin/:${PATH}' >> /etc/bashrc
echo 'PATH=/opt/arangodb/bin/:${PATH}' >> /etc/profile
