#!/bin/sh
set -e

if test -n "${HTTP_PROXY}"; then
    echo "proxy=${HTTP_PROXY}" >> /etc/yum.conf
fi

echo "proxy=${HTTP_PROXY}"
apt-get update
apt-get install -y tar curl bzip2 automake autoconf python-argparse build-essential apt-utils apt-transport-https debhelper libjemalloc-dev libssl-dev python python-pip

pip install lockfile

cd /tmp/
# curl -O http://download.opensuse.org/repositories/home:/fceller2/Debian_8.0//Release.key
# apt-key add - < Release.key
# rm Release.key

# echo 'deb http://ftp.debian.org/debian jessie-backports main' | tee /etc/apt/sources.list.d/backports.list
# echo 'deb http://download.opensuse.org/repositories/home:/fceller2/Debian_8.0/ /' | tee /etc/apt/sources.list.d/arangodbbuild.list
apt-get update
apt-get install -y gcc-5
apt-get install -y git
apt-get install -y cmake 

useradd jenkins -u 1000

echo 'PATH=/opt/arangodb/bin/:${PATH}' >> /etc/bashrc
echo 'PATH=/opt/arangodb/bin/:${PATH}' >> /etc/profile
