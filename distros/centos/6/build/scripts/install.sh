#!/bin/sh
set -e

if test -n "${HTTP_PROXY}"; then
    echo "proxy=${HTTP_PROXY}" >> /etc/yum.conf
fi

echo "proxy=${HTTP_PROXY}"
cat /etc/yum.conf
yum -y install tar wget bzip2 git automake autoconf

# get the latest gcc:
# https://www.softwarecollections.org/en/scls/rhscl/devtoolset-3/
#yum -y install centos-release-scl
#yum -y --nogpgcheck install devtoolset-3-gcc devtoolset-3-gcc-c++
# echo "running scl enable: "
# scl enable devtoolset-3 bash

cd /etc/yum.repos.d; wget http://download.opensuse.org/repositories/home:/fceller2/CentOS_CentOS-6/home:fceller2.repo
yum -y install arangodb-gcc54-5.4.0 arangodb-jemalloc-devel arangodb-jemalloc-devel-static glibc-devel python-argparse openssl-devel rpm-build cmake

useradd jenkins -u 1000

echo 'PATH=/opt/arangodb/bin/:${PATH}' >> /etc/bashrc
echo 'PATH=/opt/arangodb/bin/:${PATH}' >> /etc/profile
