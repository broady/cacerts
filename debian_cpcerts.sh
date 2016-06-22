#!/bin/bash

set -e -x

apt-get update
apt-get install -y ca-certificates
cp /etc/ssl/certs/ca-certificates.crt .
