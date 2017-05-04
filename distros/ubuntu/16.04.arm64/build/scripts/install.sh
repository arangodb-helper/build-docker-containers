#!/bin/sh
set -e

if test -n "${HTTP_PROXY}"; then
    echo "proxy=${HTTP_PROXY}" >> /etc/yum.conf
fi

echo "proxy=${HTTP_PROXY}"
apt-get update

dpkg --add-architecture arm64

#sources.list
echo 'deb-src [arch=arm64] http://ports.ubuntu.com/ xenial main restricted universe multiverse' > /etc/apt/sources.list.d/build.list
echo 'deb-src [arch=,arm64] http://ports.ubuntu.com/ xenial-updates main restricted universe multiverse' >> /etc/apt/sources.list.d/build.list
echo 'deb-src [arch=,arm64] http://ports.ubuntu.com/ xenial-security main restricted universe multiverse' >> /etc/apt/sources.list.d/build.list
echo 'deb-src [arch=,arm64] http://ports.ubuntu.com/ xenial-backports main restricted universe multiverse' >> /etc/apt/sources.list.d/build.list

echo 'deb [arch=arm64] http://ports.ubuntu.com/ xenial main restricted universe multiverse' >> /etc/apt/sources.list.d/build.list
echo 'deb [arch=arm64] http://ports.ubuntu.com/ xenial-updates main restricted universe multiverse' >> /etc/apt/sources.list.d/build.list
echo 'deb [arch=arm64] http://ports.ubuntu.com/ xenial-security main restricted universe multiverse' >> /etc/apt/sources.list.d/build.list
echo 'deb [arch=arm64] http://ports.ubuntu.com/ xenial-backports main restricted universe multiverse' >> /etc/apt/sources.list.d/build.list

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

apt-get install -y libssl-dev:arm64

apt-get install -y tar curl bzip2 git cmake automake autoconf \
	python-argparse python python-lockfile \
	apt-utils apt-transport-https \
	debhelper snapcraft libldap2-dev:arm64

# apt-get install -y mc nano
apt-get install -y g++-aarch64-linux-gnu
apt-get install -y libstdc++6:arm64

# enable this container to run arm binaries:
apt-get install -y qemu binfmt-support qemu-user-static

# for dpkg-shlibdebs we need this:
dpkg -r gcc  g++ build-essential
cd /usr/bin
ln -s aarch64-linux-gnu-gcc gcc

useradd jenkins -u 1000

echo 'PATH=/opt/arangodb/bin/:${PATH}' >> /etc/bashrc
echo 'PATH=/opt/arangodb/bin/:${PATH}' >> /etc/profile
