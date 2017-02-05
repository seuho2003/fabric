#!/bin/bash

ARCH=`uname -m`

SPLIT=4

#check to see if TEST_PKGS is set else use default (all packages)
TEST_PKGS=${TEST_PKGS:-github.com/hyperledger/fabric/...}
echo -n "Obtaining list of tests to run for the following packages: ${TEST_PKGS}"

#Some examples don't play nice with `go test`
PKGS=`go list ${TEST_PKGS} 2> /dev/null | \
                                                  grep -v /vendor/ | \
                                                  grep -v /build/ | \
                                                  grep -v /examples/chaincode/chaintool/ | \
                                                  grep -v /examples/chaincode/go/asset_management | \
                                                  grep -v /examples/chaincode/go/utxo | \
                                                  grep -v /examples/chaincode/go/rbac_tcerts_no_attrs`

if [ x$ARCH == xppc64le -o x$ARCH == xs390x ]
then
PKGS=`echo $PKGS | sed  's@'github.com/hyperledger/fabric/core/chaincode/platforms/java/test'@@g'`
PKGS=`echo $PKGS | sed  's@'github.com/hyperledger/fabric/core/chaincode/platforms/java'@@g'`
fi

echo "DONE!"

pkgCount=`echo $PKGS | wc -w`
testsPerPkg=$(( $pkgCount / $SPLIT ))
reminder=$(( $pkgCount - $SPLIT * testsPerPkg ))
#echo pkgCount:$pkgCount, testsPerPkg:$testsPerPkg, reminder:$reminder
for i in `seq $SPLIT`; do
        j=$(( $i - 1 ))
        start=$(( $j * $testsPerPkg + 1 ))
        end=$(( $i * $testsPerPkg ))
        if [ $i -eq $SPLIT ] && [ $reminder -ne 0 ];then
                end=""
        fi
        TESTS[$j]=`echo $PKGS | cut -d" " -f${start}-${end}`
done

for i in `seq ${#TESTS[@]}`; do
        j=$(( $i - 1 ))
        echo Running `echo ${TESTS[$j]} | wc -w`" tests"
        docker-compose run --name test$j unit-tests gocov test -ldflags "${GO_LDFLAGS}" ${TESTS[$j]} -p 1 -timeout=20m > coverage$i.json 2> out$i.log &
        sleep 10
done

sleep 10

tail -f out*.log | grep -v "==" | grep -v "^$" &

while :;do
        docker ps -a | grep fabric-testenv | grep -v "Exited (0)" | grep -vq Up
        if [ $? -eq 0 ];then
                echo "Unit tests failed, bringing down all docker instances..."
                docker-compose kill
                pkill tail
                docker ps -aq | xargs docker kill
                docker ps -aq | xargs docker rm
                cat out*.log
                exit 1
        fi
        docker ps | grep -q fabric-testenv || break
        sleep 1
done

echo "Finished successfully, joining gocov output"
node << EOF | docker-compose run unit-tests "gocov-xml" > report.xml
var fs = require('fs');
var coverages = [];
var unifiedReport = {
        Packages: []
}
fs.readdirSync('.').map(function(f) {
        if (f.indexOf('coverage') == -1 ) {
                return
        }
        coverages.push(f);
});

coverages.map(function(f) {
        json=JSON.parse(fs.readFileSync(f));
        unifiedReport.Packages = unifiedReport.Packages.concat(json.Packages)
});

console.log(JSON.stringify(unifiedReport))
EOF
exit 0

