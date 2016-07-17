#!/bin/bash -xe
#NUM_FILES_CHANGED=$(git diff --name-status -- sdk/node | wc -l)
git show --name-only --oneline --relative=sdk/node
NUM_FILES_CHANGED=$(git show --name-only --oneline --relative=sdk/node | wc -l)
echo "Number of files changed in sdk/node directory:" $NUM_FILES_CHANGED
NUM_PROTO_FILES_CHANGED=$(git show --name-only --oneline --relative=protos | wc -l)
git show --name-only --oneline --relative=protos
echo "Number of Proto files changed are:" $NUM_PROTO_FILES_CHANGED
if [[ "$NUM_FILES_CHANGED" -eq 0 && "$NUM_PROTO_FILES_CHANGED" -eq 0 ]]; then
echo "Node sdk files are not changed!";
exit 0
fi
curl -L https://raw.githubusercontent.com/hyperledger/fabric/master/sdk/node/package.json -o package.json
NPM_PROD_PACKAGE_VERSION=$(cat package.json | grep version | awk -F\" '{ print $4 }')
echo "Version Number in Production is:" $NPM_PROD_PACKAGE_VERSION
cd sdk/node
NPM_PR_PACKAGE_VERSION=$(cat package.json | grep version | awk -F\" '{ print $4 }')
echo "Version number in PR is:" $NPM_PR_PACKAGE_VERSION
if test "$NPM_PROD_PACKAGE_VERSION" = "$NPM_PR_PACKAGE_VERSION";  then
 echo "Package Version has to change, Please run npm version <major> <minor> <patch>"
 exit 1
fi
echo "npm version and npm publish has to run in Merge"
