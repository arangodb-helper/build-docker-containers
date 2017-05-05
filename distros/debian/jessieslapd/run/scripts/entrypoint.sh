#!/bin/bash

cd /scripts
pwd

service slapd stop
rm -rf /etc/ldap && rm -rf /var/lib/ldap && rm -rf /usr/share/slapd

mkdir -p /etc/ssl/certs
mkdir -p /etc/ssl/private

mv ldap_conf  /etc/ldap
mv ldap_db    /var/lib/ldap
mv slapd_conf /usr/share/slapd

chown -R openldap:openldap /etc/ldap/slapd.d
chown -R openldap:openldap /var/lib/ldap

# create certs
mkdir /cert
mkdir /etc/ssl/templates
echo "cn = $LDAP_CERT_CN" >> crypto/ldap_server.conf

mv crypto/ca_server.conf   /etc/ssl/templates/ca_server.conf
mv crypto/ldap_server.conf /etc/ssl/templates/ldap_server.conf

certtool -p --outfile /etc/ssl/private/ca_server.key
certtool -s --load-privkey /etc/ssl/private/ca_server.key --template /etc/ssl/templates/ca_server.conf --outfile /etc/ssl/certs/ca_server.pem
certtool -p --sec-param high --outfile /etc/ssl/private/ldap_server.key
certtool -c --load-privkey /etc/ssl/private/ldap_server.key --load-ca-certificate /etc/ssl/certs/ca_server.pem \
            --load-ca-privkey /etc/ssl/private/ca_server.key --template /etc/ssl/templates/ldap_server.conf --outfile /etc/ssl/certs/ldap_server.pem

usermod -aG ssl-cert openldap
chown :ssl-cert /etc/ssl/private/ldap_server.key
chmod 640       /etc/ssl/private/ldap_server.key

cp /etc/ssl/certs/ca_server.pem /cert/


service slapd start

echo $LDAP_CERT_CN

echo "Press CTRL+P CTRL+Q to release the shell."

# stimulate docker a bit
while true; do sleep 60; done
