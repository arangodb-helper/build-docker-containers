
first build the image from the `Dockerfile`

    cd build-docker-containers/distros/debian/jessieslapd/run
    docker build -t {yourImageName} .
    
    



the command

    docker run -d -e "LDAP_CERT_CN={commonName}" \
    -v {hostPathToAnyDirectoryForCACertReceiving}:/cert/ -p {hostIP}:{hostPort}:389 {imagename}
    
starts a container (instance) of the image `imagename`. A LDAP server with the CN `commonName` is listening on the host port `hostPort`s IP `hostIP`. The CA cert is copied to `hostPathToAnyDirectoryForCACertReceiving`.

Note:

remove `{` and `}` as they only indicating the wildcard parameter name boundary.


Example:

    docker run -d -e "LDAP_CERT_CN=127.0.0.1" \
    -v /home/user/ldapcacert/:/cert/ -p 127.0.0.1:5555:389 jessie-ldap

This command start a container with an ldap server listening on 127.0.0.1:5555. For your ldap client you can use the ca certificate that is in /home/user/ldapcacert/.



Run the ldap test

    cd arangodb-repo-base
    ./scripts/unittest ldap  --ldapHost {hostIP} --ldapPort {hostPort} --caCertFilePath {pathToLdapCACert}
    
    
this will run the test located at
https://github.com/arangodb/arangodb/blob/devel/js/client/modules/%40arangodb/testsuites/ldap.js
