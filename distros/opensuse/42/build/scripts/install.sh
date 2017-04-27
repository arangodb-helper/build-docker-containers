#!/bin/sh
set -e

if test -n "${HTTP_PROXY}"; then
    echo "proxy=${HTTP_PROXY}" >> /etc/yum.conf
fi

echo "proxy=${HTTP_PROXY}"
zypper refresh

useradd jenkins -u 1000

########

zypper -n install git tar cmake gcc6 gcc6-c++ rpm-build curl bzip2 python-argparse ca-certificates-mozilla \
libopenssl-devel openldap2-devel jemalloc-devel jemalloc-devel-static glibc-devel 
