#!/bin/bash

# Generate CA
echo "------------------ CA ---------------------"
CAPATH="tls/ca"
mkdir -p ${CAPATH}
openssl genpkey -algorithm RSA -out ${CAPATH}/ca.key
openssl req -new -x509 -key ${CAPATH}/ca.key -out ${CAPATH}/ca.crt -subj '/CN=ca/O=YourORG/C=US'
echo

# Generate server
echo "------------------ SERVER ---------------------"
CERTPATH="tls/server/"
mkdir -p ${CERTPATH}/ssl
openssl genpkey -algorithm RSA -out ${CERTPATH}/ssl/server.key
openssl req -new -key ${CERTPATH}/ssl/server.key -out tls/server/server.csr -addext "subjectAltName = DNS:server" -subj '/CN=server/O=YourORG/C=US'
openssl x509 -req -in ${CERTPATH}/server.csr -CA ${CAPATH}/ca.crt -CAkey ${CAPATH}/ca.key -CAcreateserial -out ${CERTPATH}/ssl/server.crt
cp ${CAPATH}/ca.crt ${CERTPATH}/ssl/
echo

# Generate client
echo "------------------ CLIENT ---------------------"
CERTPATH="tls/client/"
mkdir -p ${CERTPATH}/ssl
openssl genpkey -algorithm RSA -out ${CERTPATH}/ssl/client.key
openssl req -new -key ${CERTPATH}/ssl/client.key -out ${CERTPATH}/client.csr -addext "subjectAltName = DNS:client" -subj '/CN=client/O=YourORG/C=US'
openssl x509 -req -in ${CERTPATH}/client.csr -CA ${CAPATH}/ca.crt -CAkey ${CAPATH}/ca.key -CAcreateserial -out ${CERTPATH}/ssl/client.crt
cp ${CAPATH}/ca.crt ${CERTPATH}/ssl/
# O'hack that will make the key accessible for Gunicorn
#  ... no it's not the best way to do such things
chmod 0644 ${CERTPATH}/ssl/client.key
