
the command

    docker run -d -e "LDAP_CERT_CN={commonName}" \
    -v {hostPathForCACertReceiving}:/cert/ -p {hostIP}:{hostPort}:389 {imagename}
    
starts a conatiner (instance) of the image `imagename`. A LDAP server with the CN `commonName` is listening on the host port `hostPort`s IP `hostIP`. The CA cert is copied to `hostPathForCACertReceiving`.

Note:

remove `{` and `}` as they only indicating the wildcard parameter name boundary.


Example:

    docker run -d -e "LDAP_CERT_CN=127.0.0.1" \
    -v /home/user/ldapcacert/:/cert/ -p 127.0.0.1:5555:389 jessie-ldap

This command start a continer with an ldap server listening on 127.0.0.1:5555. For your ldap client you can use the ca certificate that is in /home/user/ldapcacert/.
