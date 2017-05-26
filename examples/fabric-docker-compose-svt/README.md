# fabric-docker-compose-svt

## Cloning the repository:
Clone the repository under fabric/examples using `git clone https://github.com/suryalnvs/fabric-docker-compose-svt`

## Usage:
The simplest method to start a network with kafka/zookeeper as ordering service is just issue command `./reset.sh`

Currently, by customizing docker-compose-base.yaml in base directory, we enabled peer0Org2 as admin, and all other 3 peers
in the 2 organizations are members Role.

If that doesn't work, then fall back to the commands below

```
	./network_setup.sh -n [channel-name] -s -c -t [cli timer] -f [compose yaml] <up|down|retstart>
   		-n       channel name
		-c       enable couchdb
		-f       Docker compose file to be used for the network among docker-compose-cli.yaml and docker-compose-e2e.yaml
		-s       Enable TLS
		-t       CLI container timeout
		up       Launch the network
		down     teardown the network
  		restart  Restart the network
for example: ./network_setup.sh -n "mychannel" -c -s -t 10  restart (with couchdb and tls)
             ./network_setup.sh -n "mychannel" -c -t 10  up (with couchdb only and tls disabled)
	     ./network_setup.sh -n "mychannel" -s -t 10  restart (with tls enabled and no couchdb)
	     ./network_setup.sh -n "mychannel" -t 10  restart (no tls and no couchdb)
``` 

1) docker-compose-e2e.yaml is used to launch the network with two orderers, three kafka brokers, three zookeepers, two organizations with two peers in each, one ca per each organization. 
Command to pass in docker-compose-e2e.yaml file to the command is
``` ./network_setup.sh -n [channel-name] -s -c -t [cli timer] -f docker-compose-e2e.yaml <up|down|retstart> ```
2) docker-compose-cli.yaml is used to launch a cli container that runs end-to-end script along with the network described above for docker-compose-e2e.yaml. 
Command to pass in docker-compose-cli.yaml file to the command is
``` ./network_setup.sh -n [channel-name] -s -c -t [cli timer] -f docker-compose-cli.yaml <up|down|retstart> ```
3) docker-compose-couchdb.yaml is used to include couchdb containers when -c is passed in the command as shown in above example.
``` ./network_setup.sh -n [channel-name] -s -c -f docker-compose-e2e.yaml <up|down|restart> ```

