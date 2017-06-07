#!/bin/bash
#
# Copyright IBM Corp. All Rights Reserved.
#
# SPDX-License-Identifier: Apache-2.0
#

export VERSION=1.0.0-alpha3
export ARCH=$(echo "$(uname -s|tr '[:upper:]' '[:lower:]'|sed 's/mingw64_nt.*/windows/')-$(uname -m | sed 's/x86_64/amd64/g')" | awk '{print tolower($0)}')
#Set MARCH variable i.e ppc64le,s390x,x86_64,i386
MARCH=`uname -m`

dockerFabricPull() {
  local FABRIC_TAG=x86_64-1.0.0-alpha3-snapshot-52853f8
  for IMAGES in peer orderer couchdb ccenv javaenv kafka zookeeper tools; do
      echo "==> FABRIC IMAGE: $IMAGES"
      echo
      docker pull rameshthoomu/fabric-$IMAGES-x86_64:$FABRIC_TAG
      docker tag rameshthoomu/fabric-$IMAGES-x86_64:$FABRIC_TAG hyperledger/fabric-$IMAGES
      docker tag rameshthoomu/fabric-$IMAGES-x86_64:$FABRIC_TAG hyperledger/fabric-$IMAGES:$FABRIC_TAG
  done
}

dockerCaPull() {
      local CA_TAG=x86_64-1.0.0-alpha3-snapshot-c9372be
      echo "==> FABRIC CA IMAGE"
      echo
      docker pull rameshthoomu/fabric-ca-x86_64:$CA_TAG
      docker tag rameshthoomu/fabric-ca-x86_64:$CA_TAG hyperledger/fabric-ca:$CA_TAG
}

: ${CA_TAG:="$MARCH-$VERSION"}
: ${FABRIC_TAG:="$MARCH-$VERSION"}

echo "===> Downloading platform binaries"
curl https://nexus.hyperledger.org/content/repositories/snapshots/org/hyperledger/fabric/fabric-binary/${ARCH}-${VERSION}-SNAPSHOT/fabric-binary-${ARCH}-${VERSION}-20170606.184501-5.tar.gz | tar xz

echo "===> Pulling fabric Images"
dockerFabricPull ${FABRIC_TAG}

echo "===> Pulling fabric ca Image"
dockerCaPull ${CA_TAG}
echo
echo "===> List out hyperledger docker images"
docker images | grep hyperledger*
