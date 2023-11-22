#!/bin/bash

# Declare the variable that stores the location of the created private key
private_key="/etc/ssl/private/nginx-selfsigned.key"

# Declare the variable that stores the location of the created CSR
certificate_signing_request="/etc/ssl/certs/nginx-selfsigned.cst"

# Declare the options
options="/C=MO/L=MD/O=1334/OU=STUDENT/CN=amait-ou.42.fr"

# Generate the private key
openssl genpkey -algorithm RSA -out "$private_key"

# Generate the Certificate Signing Request (CSR)
openssl req -new -key "$private_key" -out "$certificate_signing_request" -subj "$options"

# Generate Self-Signed Certificate
openssl x509 -req -in "$certificate_signing_request" -signkey "$private_key" -out "/etc/ssl/certs/nginx-selfsigned.crt"

# set ssl_certificate in nginx snippets folder
echo "
ssl_certificate /etc/ssl/certs/nginx-selfsigned.crt;
ssl_certificate_key /etc/ssl/private/nginx-selfsigned.key;
" > /etc/nginx/snippets/self-signed.conf

# start the nginx daemon
nginx -g "daemon off;"
