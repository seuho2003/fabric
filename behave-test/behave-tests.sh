#!/bin/bash -eu
set -o pipefail

cd $GOPATH/src/github.com/hyperledger/fabric/bddtests
echo "==============>"
docker-compose --version
echo "==============>"
#behave -k -D cache-deployment-spec
behave -k -D cache-deployment-spec features/bootstrap.feature

