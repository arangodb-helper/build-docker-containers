#!/bin/sh
set -e

if test -n "${HTTP_PROXY}"; then
    echo "proxy=${HTTP_PROXY}" >> /etc/yum.conf
fi

echo "proxy=${HTTP_PROXY}"
apt-get update

apt-get install -y tar curl bzip2 git cmake automake autoconf python-argparse build-essential apt-utils apt-transport-https libjemalloc1 openssl ruby-rspec rubygems ruby-diff-lcs ri gdb
apt-get install -y ruby 1.9.3
#cd /etc/alternatives
#ln -sf /usr/bin/ruby1.9.3 ruby
#cd
#gem install bundler
#curl -O https://raw.githubusercontent.com/arangodb/arangodb/devel/UnitTests/HttpInterface/Gemfile
#bundle

useradd jenkins -u 1000

echo 'PATH=/opt/arangodb/bin/:${PATH}' >> /etc/bashrc
echo 'PATH=/opt/arangodb/bin/:${PATH}' >> /etc/profile
