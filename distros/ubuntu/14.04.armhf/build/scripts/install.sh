#!/bin/sh
set -e

if test -n "${HTTP_PROXY}"; then
    echo "proxy=${HTTP_PROXY}" >> /etc/yum.conf
fi

echo "proxy=${HTTP_PROXY}"
apt-get update

dpkg --add-architecture armhf
dpkg --add-architecture arm64

#precise
# trusty

#sources.list
echo 'deb-src [arch=armhf,arm64] http://ports.ubuntu.com/ trusty main restricted universe multiverse' > /etc/apt/sources.list.d/build.list
echo 'deb-src [arch=armhf,arm64] http://ports.ubuntu.com/ trusty-updates main restricted universe multiverse' >> /etc/apt/sources.list.d/build.list
echo 'deb-src [arch=armhf,arm64] http://ports.ubuntu.com/ trusty-security main restricted universe multiverse' >> /etc/apt/sources.list.d/build.list
echo 'deb-src [arch=armhf,arm64] http://ports.ubuntu.com/ trusty-backports main restricted universe multiverse' >> /etc/apt/sources.list.d/build.list

echo 'deb [arch=armhf,arm64] http://ports.ubuntu.com/ trusty main restricted universe multiverse' >> /etc/apt/sources.list.d/build.list
echo 'deb [arch=armhf,arm64] http://ports.ubuntu.com/ trusty-updates main restricted universe multiverse' >> /etc/apt/sources.list.d/build.list
echo 'deb [arch=armhf,arm64] http://ports.ubuntu.com/ trusty-security main restricted universe multiverse' >> /etc/apt/sources.list.d/build.list
echo 'deb [arch=armhf,arm64] http://ports.ubuntu.com/ trusty-backports main restricted universe multiverse' >> /etc/apt/sources.list.d/build.list

cat /etc/apt/sources.list.d/build.list

#sources.list
echo 'deb [arch=i386,amd64] http://archive.ubuntu.com/ubuntu/ trusty main restricted universe multiverse' > /etc/apt/sources.list
echo 'deb [arch=i386,amd64] http://archive.ubuntu.com/ubuntu/ trusty-updates main restricted universe multiverse' >> /etc/apt/sources.list
echo 'deb [arch=i386,amd64] http://archive.ubuntu.com/ubuntu/ trusty-security main restricted universe multiverse' >> /etc/apt/sources.list

echo 'deb-src [arch=i386,amd64] http://archive.ubuntu.com/ubuntu/ trusty main restricted universe multiverse' >> /etc/apt/sources.list
echo 'deb-src [arch=i386,amd64] http://archive.ubuntu.com/ubuntu/ trusty-updates main restricted universe multiverse' >> /etc/apt/sources.list
echo 'deb-src [arch=i386,amd64] http://archive.ubuntu.com/ubuntu/ trusty-security main restricted universe multiverse' >> /etc/apt/sources.list

cat /etc/apt/sources.list

apt-get update

#apt-get purge -y libssl-dev 

apt-get install -y libssl-dev:armhf
apt-get install -y libssl-dev:arm64

apt-get install -y tar wget bzip2 git automake autoconf build-essential \
libpython2.7-stdlib python python-lockfile \
apt-utils apt-transport-https \
debhelper libjemalloc-dev

apt-get install -y mc nano
apt-get install -y g++-arm-linux-gnueabihf
apt-get install -y g++-aarch64-linux-gnu

apt-get install -y software-properties-common
#add-apt-repository ppa:gwibber-daily/ppa
sudo add-apt-repository -y ppa:george-edison55/cmake-3.x
#sudo apt-get update
#apt-get install -y cmake

cd /tmp/
wget http://download.opensuse.org/repositories/home:/fceller2/xUbuntu_14.04/Release.key
apt-key add - < Release.key
rm Release.key


echo 'deb http://download.opensuse.org/repositories/home:/fceller2/xUbuntu_14.04/ /' | tee /etc/apt/sources.list.d/arangodbbuild.list
apt-get update
apt-get install -y arangodb-gcc54

apt-get install -y cmake

useradd jenkins -u 1000

echo 'PATH=/opt/arangodb/bin/:${PATH}' >> /etc/bashrc
echo 'PATH=/opt/arangodb/bin/:${PATH}' >> /etc/profile
