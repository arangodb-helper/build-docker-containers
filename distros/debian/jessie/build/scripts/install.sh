#!/bin/sh
set -e

if test -n "${HTTP_PROXY}"; then
    echo "proxy=${HTTP_PROXY}" >> /etc/yum.conf
fi

echo "proxy=${HTTP_PROXY}"
apt-get update
apt-get install -y tar wget bzip2 automake autoconf python-argparse build-essential apt-utils apt-transport-https debhelper libjemalloc-dev libssl-dev python python-pip

pip install lockfile

cd /tmp/
wget http://download.opensuse.org/repositories/home:/fceller2/Debian_8.0//Release.key
apt-key add - < Release.key
rm Release.key


http://download.opensuse.org/repositories/home:/dothebart:/branches:/devel:/tools:/building/ /home:dothebart:branches:devel:tools:building.repo

echo 'deb http://ftp.debian.org/debian jessie-backports main' | tee /etc/apt/sources.list.d/backports.list
echo 'deb http://download.opensuse.org/repositories/home:/fceller2/Debian_8.0/ /' | tee /etc/apt/sources.list.d/arangodbbuild.list
apt-get update
apt-get install -y arangodb-gcc54 
apt-get -t jessie-backports install -y git
apt-get -t jessie-backports install -y cmake 

useradd jenkins -u 1000

echo 'PATH=/opt/arangodb/bin/:${PATH}' >> /etc/bashrc
echo 'PATH=/opt/arangodb/bin/:${PATH}' >> /etc/profile
