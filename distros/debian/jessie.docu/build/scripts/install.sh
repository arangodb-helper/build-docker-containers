#!/bin/sh
set -e

if test -n "${HTTP_PROXY}"; then
    echo "proxy=${HTTP_PROXY}" >> /etc/yum.conf
fi

echo "proxy=${HTTP_PROXY}"
apt-get update
apt-get install -y tar wget bzip2 make python-argparse python-setuptools build-essential apt-utils apt-transport-https debhelper libjemalloc-dev libssl-dev python python-pip ditaa xvfb libidn11-dev daemon

pip install lockfile

cd /tmp/
wget http://download.opensuse.org/repositories/home:/fceller2/Debian_8.0//Release.key
apt-key add - < Release.key
rm Release.key

echo 'deb http://ftp.debian.org/debian jessie-backports main' | tee /etc/apt/sources.list.d/backports.list
echo 'deb http://download.opensuse.org/repositories/home:/fceller2/Debian_8.0/ /' | tee /etc/apt/sources.list.d/arangodbbuild.list
apt-get update
apt-get install -y arangodb-gcc54 
apt-get -t jessie-backports install -y git
apt-get -t jessie-backports install -y cmake 
apt-get -t jessie-backports install -y git
apt-get -t jessie-backports install -y calibre

cd /root

git clone https://github.com/arangodb-helper/markdown-pp/; cd markdown-pp; python setup.py install
git clone https://github.com/amperser/proselint.git; cd proselint; python setup.py install 
npm install gitbook-cli -g

sed -i /etc/fstab -e "s;node;jenkins;"

mkdir /home/jenkins

echo 'PATH=/opt/arangodb/bin/:${PATH}' >> /etc/bashrc
echo 'PATH=/opt/arangodb/bin/:${PATH}' >> /etc/profile

rm -f /var/cache/apt/archives/*deb
