#!/bin/sh
set -e

if test -n "${HTTP_PROXY}"; then
    echo "proxy=${HTTP_PROXY}" >> /etc/yum.conf
fi

echo "proxy=${HTTP_PROXY}"
# install the bare arangodb dependencies:
zypper -n install -y install tar bzip2 openssl wget

wget http://download.opensuse.org/repositories/home:/fceller2/openSUSE_13.1/repodata/repomd.xml.key

rpm --import repomd.xml.key

zypper addrepo http://download.opensuse.org/repositories/home:/fceller2/openSUSE_13.1/home:fceller2.repo

zypper -n install arangodb-jemalloc rspec
