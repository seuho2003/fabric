#!/bin/bash -eu

##################################################
# This script pulls docker images from hyperledger
# docker hub repository and Tag it as
# hyperledger/fabric-<image> latest tag
##################################################

dockerFabricPull() {
  local FABRIC_TAG=$1
  local ORG_NAME=$2
  for IMAGES in peer orderer couchdb ccenv javaenv kafka zookeeper; do
      echo "==> FABRIC IMAGE: $IMAGES"
      echo
    if [ "${ORG_NAME}" == "hyperledger" ]; then
      echo "========> from $ORG_NAME" docker hub
      docker pull $ORG_NAME/fabric-$IMAGES:$FABRIC_TAG
      docker tag $ORG_NAME/fabric-$IMAGES:$FABRIC_TAG hyperledger/fabric-$IMAGES:$FABRIC_TAG
      docker tag $ORG_NAME/fabric-$IMAGES:$FABRIC_TAG hyperledger/fabric-$IMAGES
    else
      echo "========> from $ORG_NAME" docker hub
      docker pull $ORG_NAME/fabric-$IMAGES-$ARCH:$FABRIC_TAG
      docker tag $ORG_NAME/fabric-$IMAGES-$ARCH:$FABRIC_TAG hyperledger/fabric-$IMAGES:$FABRIC_TAG
      docker tag $ORG_NAME/fabric-$IMAGES-$ARCH:$FABRIC_TAG hyperledger/fabric-$IMAGES
      docker rmi -f $ORG_NAME/fabric-$IMAGES-$ARCH:$FABRIC_TAG
    fi
  done
}

dockerCaPull() {
      local CA_TAG=$1
      local ORG_NAME=$2
      echo "==> FABRIC CA IMAGE"
      echo
    if [ "${ORG_NAME}" == "hyperledger" ]; then
      docker pull $ORG_NAME/fabric-ca:$CA_TAG
      docker tag $ORG_NAME/fabric-ca:$CA_TAG hyperledger/fabric-ca:$CA_TAG
      docker tag $ORG_NAME/fabric-ca:$CA_TAG hyperledger/fabric-ca
    else
      docker pull $ORG_NAME/fabric-ca-$ARCH:$CA_TAG
      docker tag $ORG_NAME/fabric-ca-$ARCH:$CA_TAG hyperledger/fabric-ca
      docker tag $ORG_NAME/fabric-ca-$ARCH:$CA_TAG hyperledger/fabric-ca:$CA_TAG
      docker rmi -f $ORG_NAME/fabric-ca-$ARCH:$CA_TAG
    fi
}
usage() {
      echo "Description "
      echo
      echo "Pulls docker images from hyperledger dockerhub repository"
      echo "tag as hyperledger/fabric-<image>:latest"
      echo
      echo "USAGE: "
      echo
      echo "./download-dockerimages.sh [-c <fabric-ca tag>] [-f <fabric tag>] [-o <dockerhub org name>]"
      echo "      -c fabric-ca docker image tag"
      echo "      -f fabric docker image tag"
      echo "      -o orgnization name"
      echo
      echo "EXAMPLE:"
      echo "./download-dockerimages.sh -c x86_64-1.0.0-alpha -f x86_64-1.0.0-alpha -o hyperledger"
      echo
      echo "By default, pulls fabric-ca and fabric 1.0.0-alpha docker images"
      echo "from hyperledger dockerhub"
      exit 0
}

while getopts "\?hc:f:o:" opt; do
  case "$opt" in
     c) CA_TAG="$OPTARG"
        echo "Pull CA IMAGES"
        ;;
     f) FABRIC_TAG="$OPTARG"
        echo "Pull FABRIC TAG"
        ;;
     o) ORG_NAME="$OPTARG"
        echo "ORG NAME"
        ;;
     \?|h) usage
        echo "Print Usage"
        ;;
  esac
done

: ${CA_TAG:="x86_64-1.0.0-alpha"}
: ${FABRIC_TAG:="x86_64-1.0.0-alpha"}
: ${ORG_NAME:="hyperledger"}

ARCH=$(uname -m)
echo "===========> $ARCH"

echo "===> Pulling fabric Images"
dockerFabricPull ${FABRIC_TAG} ${ORG_NAME}

echo "===> Pulling fabric ca Image"
dockerCaPull ${CA_TAG} ${ORG_NAME}
echo
echo "===> List out hyperledger docker images"
docker images | grep hyperledger*
