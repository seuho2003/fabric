#!/bin/bash
if [ "$1" = "false" ] && [ "$2" != "hyperledger" ]; then
rm -rf $HOME/gopath/src/github.com/hyperledger/
echo "Deleted hyperledger folder"
mkdir -p $HOME/gopath/src/github.com/hyperledger/fabric
echo "folder created"
ls $HOME/gopath/src/github.com/$2/$3/
cp -r $HOME/gopath/src/github.com/$2/$3/* $HOME/gopath/src/github.com/hyperledger/fabric/
#mv $HOME//gopath/src/github.com/hyperledger/$3 $HOME/gopath/src/github.com/hyperledger/fabric
ls $HOME/gopath/src/github.com/hyperledger/fabric/
echo "Copied User Directory into hyperledger"
elif [ "$2" != "hyperledger" ]; then
mkdir -p $HOME/gopath/src/github.com/hyperledger/fabric
echo "folder created"
ls $HOME/gopath/src/github.com/$2/$3/
cp -r $HOME/gopath/src/github.com/$2/$3/* $HOME/gopath/src/github.com/hyperledger/fabric/
mv $HOME/gopath/src/github.com/$2 $HOME/gopath/src/github.com/hyperledger
fi

