#!/bin/bash -eu
set -o pipefail

apt-get update -qq

# install docker-compose
curl -L https://github.com/docker/compose/releases/download/1.10.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# install Docker.io
apt-get install --yes docker.io

# Install behave, pip, python modules
apt-get install --yes python-dev
apt-get install --yes libyaml-dev
apt-get install --yes libffi-dev
apt-get install --yes build-essential
apt-get install --yes libssl-dev
apt-get install --yes python-setuptools
apt-get install --yes python-pip
apt-get install --yes python-crypto

pip install --upgrade pip
pip install --upgrade grpcio
pip install behave
pip install nose
pip install  --upgrade grpcio-tools
pip install "pysha3==1.0b1"
pip install  b3j0f.aop
pip install jinja2
pip install pyopenssl
pip install ecdsa
pip install python-slugify
pip install pyyaml

# updater-server, update-engine, and update-service-common dependencies (for running locally)
pip install -I flask==0.10.1 python-dateutil==2.2 pytz==2014.3 pyyaml==3.10 couchdb==1.0 flask-cors==2.0.1 requests==2.4.3

# Required to update six for grpcio
pip install --ignore-installed six
