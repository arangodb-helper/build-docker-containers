#!/bin/sh
set -e

if test -n "${HTTP_PROXY}"; then
    echo "proxy=${HTTP_PROXY}" >> /etc/yum.conf
fi

echo "proxy=${HTTP_PROXY}"
cat /etc/yum.conf
# install the bare arangodb dependencies:
yum -y install tar bzip2 openssl curl gdb

cd /etc/yum.repos.d; curl -O http://download.opensuse.org/repositories/home:/fceller2/CentOS_CentOS-6/home:fceller2.repo
# yum -y install rspec

useradd jenkins -u 1000
