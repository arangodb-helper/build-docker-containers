#!/bin/sh
set -e

if test -n "${HTTP_PROXY}"; then
    echo "proxy=${HTTP_PROXY}" >> /etc/yum.conf
fi

echo "proxy=${HTTP_PROXY}"

apt-get update

apt-get install wget python-setuptools python python-pip python-argparse 

cd /tmp/
wget http://download.opensuse.org/repositories/home:/fceller2/Debian_8.0//Release.key
apt-key add - < Release.key
rm Release.key

# First the more modern stuff so we don't need to update over packages:
echo 'deb http://ftp.debian.org/debian jessie-backports main' | tee /etc/apt/sources.list.d/backports.list
echo 'deb http://download.opensuse.org/repositories/home:/fceller2/Debian_8.0/ /' | tee /etc/apt/sources.list.d/arangodbbuild.list

apt-get update

apt-get install -y arangodb-gcc54 
apt-get -t jessie-backports install -y git
apt-get -t jessie-backports install -y cmake 
apt-get -t jessie-backports install -y git
apt-get -t jessie-backports install -y calibre

apt-get install -y tar wget bzip2 make build-essential apt-utils apt-transport-https debhelper libjemalloc-dev libssl-dev ditaa xvfb libidn11-dev daemon

# work around broken binfmt_misc support:
rm -f /usr/bin/ditaa
printf '#!/bin/bash
java -jar /usr/share/ditaa/ditaa.jar $@
' > /usr/bin/ditaa
chmod a+x /usr/bin/ditaa



rm -f /var/cache/apt/archives/*deb || true
rm -f /var/lib/apt/lists/* || true

