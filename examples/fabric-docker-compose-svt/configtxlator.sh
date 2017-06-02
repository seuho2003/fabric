#!/bin/bash

# Require jq installed. `brew install jq` for Mac.
# Also need configtxlator started and listening on port 7059 by default
die() {
    echo "$1"
    exit 1
}

bigMsg() {
    echo
    echo "####################################################################################"
    echo "$1"
    echo "####################################################################################"
    echo
}

# set -x

bigMsg "Beginning bootstrap editing example"

CONFIGTXGEN=../../build/bin/configtxgen

bigMsg "Creating bootstrap block"

$CONFIGTXGEN -profile TwoOrgsOrdererGenesis -outputBlock ./channel-artifacts/default.orderer.genesis.block || die "Error generating genesis block"

bigMsg "Decoding genesis block"

curl -X POST --data-binary @./channel-artifacts/default.orderer.genesis.block http://127.0.0.1:7059/protolator/decode/common.Block > ./channel-artifacts/default_genesis_block.json || die "Error decoding genesis block"

bigMsg "Updating genesis config"

# Basically we can customize anything to override default values and then encode the customized json into orderer genesis block
jq ".data.data[0].payload.data.config.channel_group.groups.Orderer.values.BatchSize.value.maxMessageCount = 20" ./channel-artifacts/default_genesis_block.json > ./channel-artifacts/updated_genesis_block.json

bigMsg "Re-encoding the updated genesis block"

curl -X POST --data-binary @./channel-artifacts/updated_genesis_block.json http://127.0.0.1:7059/protolator/encode/common.Block > ./channel-artifacts/orderer.genesis.proto

bigMsg "Bootstrapping edit complete"
