# this wraps https://github.com/arangodb-helper/jenkins-dind-agent to add our own registry certificate.

FROM mesosphere/jenkins-dind:0.3.1
RUN mkdir -p /etc/docker/certs.d/192.168.0.1/
COPY domain.crt /etc/docker/certs.d/192.168.0.1/ca.cert