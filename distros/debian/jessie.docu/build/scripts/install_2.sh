#!/bin/bash
set +e
pip install lockfile

cd /root

git clone https://github.com/arangodb-helper/markdown-pp/&& cd markdown-pp; python setup.py install; cd ..; rm -rf markdown-pp
git clone https://github.com/amperser/proselint.git; cd proselint; python setup.py install; cd ..; rm -rf proselint


npm install gitbook-cli -g

sed -i /etc/fstab -e "s;node;jenkins;"

mkdir /home/jenkins

echo 'PATH=/opt/arangodb/bin/:${PATH}' >> /etc/bashrc
echo 'PATH=/opt/arangodb/bin/:${PATH}' >> /etc/profile


for i in 3.1 3.2 devel; do
    mkdir -p /tmp/$i
    cd /tmp/$i
    for book in AQL HTTP Manual; do 
        curl -O https://raw.githubusercontent.com/arangodb/arangodb/$i/Documentation/Books/${book}/book.json
        gitbook install -g
    done
    https://raw.githubusercontent.com/arangodb/Cookbook/master/recipes/book.json
    gitbook install -g
    pwd
    touch blarg
done

cp -a /tmp/devel /tmp/1
