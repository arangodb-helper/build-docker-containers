FROM debian:jessie
MAINTAINER Manuel Baesler <manuel@arangodb.com>

expose 389

run apt-get update && apt-get install -y aptitude && \
    export DEBIAN_FRONTEND=noninteractive && \
    aptitude install -y htop vim iotop iftop tcpflow slapd ldap-utils gnutls-bin ssl-cert

copy ./scripts /scripts
entrypoint ["./scripts/entrypoint.sh"]
