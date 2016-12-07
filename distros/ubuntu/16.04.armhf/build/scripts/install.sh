#!/bin/sh
set -e

if test -n "${HTTP_PROXY}"; then
    echo "proxy=${HTTP_PROXY}" >> /etc/yum.conf
fi

echo "proxy=${HTTP_PROXY}"
apt-get update

dpkg --add-architecture armhf
dpkg --add-architecture arm64

#sources.list
echo 'deb-src [arch=armhf,arm64] http://ports.ubuntu.com/ xenial main restricted universe multiverse' > /etc/apt/sources.list.d/build.list
echo 'deb-src [arch=armhf,arm64] http://ports.ubuntu.com/ xenial-updates main restricted universe multiverse' >> /etc/apt/sources.list.d/build.list
echo 'deb-src [arch=armhf,arm64] http://ports.ubuntu.com/ xenial-security main restricted universe multiverse' >> /etc/apt/sources.list.d/build.list
echo 'deb-src [arch=armhf,arm64] http://ports.ubuntu.com/ xenial-backports main restricted universe multiverse' >> /etc/apt/sources.list.d/build.list

echo 'deb [arch=armhf,arm64] http://ports.ubuntu.com/ xenial main restricted universe multiverse' >> /etc/apt/sources.list.d/build.list
echo 'deb [arch=armhf,arm64] http://ports.ubuntu.com/ xenial-updates main restricted universe multiverse' >> /etc/apt/sources.list.d/build.list
echo 'deb [arch=armhf,arm64] http://ports.ubuntu.com/ xenial-security main restricted universe multiverse' >> /etc/apt/sources.list.d/build.list
echo 'deb [arch=armhf,arm64] http://ports.ubuntu.com/ xenial-backports main restricted universe multiverse' >> /etc/apt/sources.list.d/build.list

cat /etc/apt/sources.list.d/build.list

#sources.list
echo 'deb [arch=i386,amd64] http://archive.ubuntu.com/ubuntu/ xenial main restricted universe multiverse' > /etc/apt/sources.list
echo 'deb [arch=i386,amd64] http://archive.ubuntu.com/ubuntu/ xenial-updates main restricted universe multiverse' >> /etc/apt/sources.list
echo 'deb [arch=i386,amd64] http://archive.ubuntu.com/ubuntu/ xenial-security main restricted universe multiverse' >> /etc/apt/sources.list

echo 'deb-src [arch=i386,amd64] http://archive.ubuntu.com/ubuntu/ xenial main restricted universe multiverse' >> /etc/apt/sources.list
echo 'deb-src [arch=i386,amd64] http://archive.ubuntu.com/ubuntu/ xenial-updates main restricted universe multiverse' >> /etc/apt/sources.list
echo 'deb-src [arch=i386,amd64] http://archive.ubuntu.com/ubuntu/ xenial-security main restricted universe multiverse' >> /etc/apt/sources.list

cat /etc/apt/sources.list

apt-get update

#apt-get purge -y libssl-dev 

apt-get install -y libssl-dev:armhf
apt-get install -y libssl-dev:arm64

apt-get install -y tar wget bzip2 git cmake automake autoconf build-essential \
python-argparse python python-lockfile \
apt-utils apt-transport-https \
debhelper libjemalloc-dev snapcraft

apt-get install -y mc nano
apt-get install -y g++-arm-linux-gnueabihf
apt-get install -y g++-aarch64-linux-gnu

cd /tmp/
wget http://download.opensuse.org/repositories/home:/fceller2/xUbuntu_14.04/Release.key
apt-key add - < Release.key
rm Release.key

echo 'deb http://download.opensuse.org/repositories/home:/fceller2/xUbuntu_14.04/ /' | tee /etc/apt/sources.list.d/arangodbbuild.list
apt-get update
apt-get install -y arangodb-gcc54

useradd jenkins -u 1000

echo 'PATH=/opt/arangodb/bin/:${PATH}' >> /etc/bashrc
echo 'PATH=/opt/arangodb/bin/:${PATH}' >> /etc/profile
