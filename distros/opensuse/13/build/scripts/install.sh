#!/bin/sh
set -e

if test -n "${HTTP_PROXY}"; then
    echo "proxy=${HTTP_PROXY}" >> /etc/yum.conf
fi

echo "proxy=${HTTP_PROXY}"
zypper refresh
zypper -n install tar wget bzip2 git automake autoconf python-argparse ca-certificates-mozilla

zypper -n addrepo http://download.opensuse.org/repositories/home:/fceller2/openSUSE_13.1/home:fceller2.repo
# cmake: 
zypper -n addrepo http://download.opensuse.org/repositories/home:/dothebart:/branches:/devel:/tools:/building/openSUSE_13.2/home:dothebart:branches:devel:tools:building.repo  

wget http://download.opensuse.org/repositories/home:/fceller2/openSUSE_13.1/repodata/repomd.xml.key
rpm --import repomd.xml.key
# cmake:
wget http://download.opensuse.org/repositories/home:/dothebart:/branches:/devel:/tools:/building/openSUSE_13.2/repodata/repomd.xml.key
rpm --import repomd.xml.key

zypper -n refresh
zypper -n install arangodb-gcc54-5.4.0 arangodb-jemalloc-devel arangodb-jemalloc-devel-static glibc-devel openssl-devel rpm-build  cmake

useradd jenkins -u 1000

echo 'PATH=/opt/arangodb/bin/:${PATH}' >> /etc/bashrc
echo 'PATH=/opt/arangodb/bin/:${PATH}' >> /etc/profile
