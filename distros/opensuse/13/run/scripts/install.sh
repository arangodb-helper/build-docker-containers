#!/bin/sh
set -e

if test -n "${HTTP_PROXY}"; then
    echo "proxy=${HTTP_PROXY}" >> /etc/yum.conf
fi

echo "proxy=${HTTP_PROXY}"
# install the bare arangodb dependencies:
zypper -n install -y tar bzip2 openssl curl ruby ca-certificates-mozilla


#curl http://download.opensuse.org/repositories/home:/fceller2/openSUSE_13.1/repodata/repomd.xml.key

#rpm --import repomd.xml.key

zypper addrepo http://download.opensuse.org/repositories/home:/fceller2/openSUSE_13.1/home:fceller2.repo
zypper -n --gpg-auto-import-keys ref -s
zypper refresh

zypper -n install arangodb-jemalloc

gem install bundler

curl -O https://raw.githubusercontent.com/arangodb/arangodb/devel/UnitTests/HttpInterface/Gemfile
bundle.ruby2.1


touch /etc/rc.status
chmod a+x /etc/rc.status

useradd jenkins -u 1000

echo 'PATH=/opt/arangodb/bin/:${PATH}' >> /etc/bashrc
echo 'PATH=/opt/arangodb/bin/:${PATH}' >> /etc/profile
