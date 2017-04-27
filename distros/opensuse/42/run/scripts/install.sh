#!/bin/sh
set -e

if test -n "${HTTP_PROXY}"; then
    echo "proxy=${HTTP_PROXY}" >> /etc/yum.conf
fi

echo "proxy=${HTTP_PROXY}"
# install the bare arangodb dependencies:
zypper -n install tar bzip2 openssl curl ruby ca-certificates-mozilla jemalloc

gem install bundler

curl -O https://raw.githubusercontent.com/arangodb/arangodb/devel/UnitTests/HttpInterface/Gemfile
bundle.ruby2.1

touch /etc/rc.status
chmod a+x /etc/rc.status

useradd jenkins -u 1000
