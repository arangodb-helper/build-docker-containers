#!/bin/bash
pip install lockfile

cd /root

git clone https://github.com/arangodb-helper/markdown-pp/; cd markdown-pp; python setup.py install; cd ..; rm -rf markdown-pp
git clone https://github.com/amperser/proselint.git; cd proselint; python setup.py install; cd ..; rm -rf proselint


npm install gitbook-cli -g

sed -i /etc/fstab -e "s;node;jenkins;"

mkdir /home/jenkins

echo 'PATH=/opt/arangodb/bin/:${PATH}' >> /etc/bashrc
echo 'PATH=/opt/arangodb/bin/:${PATH}' >> /etc/profile


mkdir -p /tmp/1; cd /tmp/1;
curl -O https://raw.githubusercontent.com/arangodb/arangodb/devel/Documentation/Books/Manual/book.json
gitbook install -g

touch blarg
