# Spinup Local Peer Network

The purpose of this script is to spinup peers in local machine using docker. Peers launches on tested peer and membersrvc docker images and latest hyperledger/fabric base image. Local fabric script pulls peer, membersrvc and base images from rameshthoomu docker hub account. Look for the commit numbers of peer and membersrvc docker hub docker images from rameshthoomu docker hub account. (https://hub.docker.com/u/rameshthoomu)

Before execute local_fabric.sh script in your system, make sure your system satisfies below requirements.

1. Install docker and run docker service

2. Verify ufw firewall status in non-vagrant environment. If enable, disable with below command

- sudo ufw status
- sudo ufw disable

3. Clear `iptables` rules (if firewall rules are rejecting docker application) and re-start docker daemon.

`iptables -L` (to view iptable rules)

`iptables -D INPUT 4` (ex: to delete Reject rules from INPUT policy. 4 is the row number to delete)

####Spingup peers in local environment:

Copy or curl [**local_fabric.sh**](https://raw.githubusercontent.com/rameshthoomu/fabric/tools/localpeersetup/local_fabric.sh) file into local machine and follow below instructions to run the script.

Example:

`curl -L https://raw.githubusercontent.com/rameshthoomu/fabric/tools/localpeersetup/local_fabric.sh -o local_fabric.sh`

###Follow below steps:

1. `chmod +x local_fabric.sh` `dos2unix ./local_fabric.sh` to make sure file is good to execute in unix environment.
2. `./local_fabric.sh -n 4 -s -c 346f9fb -l debug -m pbft`
3. To launch peers with security and without Consensus, execute `./local_fabric.sh -n 4 -c 346f9fb -l debug -m noops`

```
./local_fabric.sh -n <number of peers> -s <enable security and Privacy> -c <Specific Commit> -l <Enable Logging method> -m <Consensus Mode>

OPTIONS:
-h/? - Print a usage message
-n   - Number of peers to launch
-s   - Enable Security and Privacy
-c   - Specific commit
-l   - Enable logging method
-m   - Enable consensus mode
 Example: 
./local_fabric.sh -n 4 -s -c 346f9fb -l debug -m pbft
```

**Pulling Docker Images:**

Fabric script automatically pulls specified commit of hyperledger/fabric-peer and hyperledger/fabric-membersrvc from Docker Hub (Please check the commit number associated the latest tag in rameshthoomu/peer and rameshthoomu/membersrvc docker hub). [Docker Hub Account](https://hub.docker.com/u/rameshthoomu/)

###Useful Docker Commands:

1. Kill all containers
  - `docker rm $(docker kill $(docker ps -aq))` (user rm -f to force kill)
2. Remove all exited containers
  - `docker ps -aq -f status=exited | xargs docker rm`
3. Remove all Images except 'openblockchain/baseimage'
  - `docker rmi $(docker images | grep -v 'hyperledger/fabric-baseimage:latest' | awk {'print $3'})`
4. Stop Docker container
  - `docker stop <Container ID>`
5. Start Docker container
  - `docker start <Container ID>`
6. To know running containers
  - `docker ps`
7. To know all containers (Including active and non-active)
  - `docker ps -a`
9. To view NetworkSettings of a Container
  - `docker inspect <Container ID>`
10. To View Logs of a Container
  - `docker logs -f <Container ID>`

## Testing Chaincode in CLI mode:

Enter into the container

`docker exec -it PEER0 bash` 

Note: PEER0 is a peer container name provided in local_fabric.sh script. If you are using local_fabric.sh script to launch Peers, user the above name. User is connected to the PEER0 container and executing below commands to Register, Deploy, Invoke and Query commands from container CLI

### Registering user inside Container:

Registering user on PEER0

`peer network login test_user0`

```
root@7efbae933829:/opt/gopath/src/github.com/hyperledger/fabric# peer network login test_user0
2016/07/23 00:51:09 Load docker HostConfig: %+v &{[] [] []  [] false map[] [] false [] [] [] [] host    { 0} [] { map[]} false []  0 0 0 false 0    0 0 0 []}
00:51:09.492 [crypto] main -> INFO 002 Log level recognized 'info', set to INFO
00:51:09.493 [main] networkLogin -> INFO 003 CLI client login...
00:51:09.493 [main] networkLogin -> INFO 004 Local data store for client loginToken: /var/hyperledger/production/client/
Enter password for user 'test_user0': ************
00:51:14.863 [main] networkLogin -> INFO 005 Logging in user 'test_user0' on CLI interface...
00:51:15.374 [main] networkLogin -> INFO 006 Storing login token for user 'test_user0'.
00:51:15.374 [main] networkLogin -> INFO 007 Login successful for user 'test_user0'.
00:51:15.374 [main] main -> INFO 008 Exiting.....
```

### Deploy Chaincode inside Container:
Once the user is registered in PEER0, execute the below command to deploy chaincode on PEER0. Below command is to deploy chaincode on PEER0 when peer is running with Security enabled.

```

peer chaincode deploy -u test_user0 -p github.com/hyperledger/fabric/examples/chaincode/go/chaincode_example02 -c '{"Function":"init", "Args": ["a","100", "b", "200"]}'

```
Chaincode ID creates after successful deploy and displays as output of the above command.

```
root@7efbae933829:/opt/gopath/src/github.com/hyperledger/fabric# peer chaincode deploy -u test_user0 -p github.com/hyperledger/fabric/examples/chaincode/go/chaincode_example02 -c '{"Function":"init", "Args": ["a","100", "b", "200"]}'

2016/07/23 00:51:44 Load docker HostConfig: %+v &{[] [] []  [] false map[] [] false [] [] [] [] host    { 0} [] { map[]} false []  0 0 0 false 0    0 0 0 []}
00:51:44.627 [crypto] main -> INFO 002 Log level recognized 'info', set to INFO
a5389f7dfb9efae379900a41db1503fea2199fe400272b61ac5fe7bd0c6b97cf10ce3aa8dd00cd7626ce02f18accc7e5f2059dae6eb0786838042958352b89fb
```

### Invoke Chaincode inside Container:

Submit Invoke transaction using the above chaincode ID:

(a5389f7dfb9efae379900a41db1503fea2199fe400272b61ac5fe7bd0c6b97cf10ce3aa8dd00cd7626ce02f18accc7e5f2059dae6eb0786838042958352b89fb)

```
peer chaincode invoke -u test_user0 -n a5389f7dfb9efae379900a41db1503fea2199fe400272b61ac5fe7bd0c6b97cf10ce3aa8dd00cd7626ce02f18accc7e5f2059dae6eb0786838042958352b89fb -c '{"Function": "invoke", "Args": ["a", "b", "10"]}'
```

Example:

```
root@7efbae933829:/opt/gopath/src/github.com/hyperledger/fabric# peer chaincode invoke -u test_user0 -n a5389f7dfb9efae379900a41db1503fea2199fe400272b61ac5fe7bd0c6b97cf10ce3aa8dd00cd7626ce02f18accc7e5f2059dae6eb0786838042958352b89fb -c '{"Function": "invoke", "Args": ["a", "b", "10"]}'
2016/07/23 00:55:30 Load docker HostConfig: %+v &{[] [] []  [] false map[] [] false [] [] [] [] host    { 0} [] { map[]} false []  0 0 0 false 0    0 0 0 []}
00:55:30.011 [crypto] main -> INFO 002 Log level recognized 'info', set to INFO
4532e63a-4ba4-40fa-89e7-d9985e2510c4
```

### Query Chaincode inside Container:

Submit Query Transaction using the deploy chaincode

```
peer chaincode query -n a5389f7dfb9efae379900a41db1503fea2199fe400272b61ac5fe7bd0c6b97cf10ce3aa8dd00cd7626ce02f18accc7e5f2059dae6eb0786838042958352b89fb -c '{"Function": "query", "Args": ["a"]}'
```

Example:

```
root@7efbae933829:/opt/gopath/src/github.com/hyperledger/fabric# peer chaincode query -u test_user0 -n a5389f7dfb9efae379900a41db1503fea2199fe400272b61ac5fe7bd0c6b97cf10ce3aa8dd00cd7626ce02f18accc7e5f2059dae6eb0786838042958352b89fb -c '{"Function": "query", "Args": ["a"]}'
2016/07/23 00:52:29 Load docker HostConfig: %+v &{[] [] []  [] false map[] [] false [] [] [] [] host    { 0} [] { map[]} false []  0 0 0 false 0    0 0 0 []}
00:52:29.035 [crypto] main -> INFO 002 Log level recognized 'info', set to INFO
100

```
## Use Case: Modify existing configuration settings of core.yaml in peer docker image:

Follow the below steps to achieve this. 

### 1. Pull images from DockerHub

First, pull the latest images published by the Hyperledger fabric project from [Docker Hub](https://hub.docker.com/u/rameshthoomu/)

```
  docker pull rameshthoomu/peer:latest
  docker pull rameshthoomu/membersrvc:latest

Note:You can provide specific commit build available in [Docker Hub](https://hub.docker.com/u/rameshthoomu)
```

Once images are pulled from dockerhub, follow below process, if you want to modify configuration peer or membersrvc images.
List out all the docker images available in your system:

`docker images`

```
rameshthoomu/peer     3e0e80a             895b42b528a6        3 days ago          1.447 GB
```

### 2. Running Docker Image

Specify the ImageID or Imagename from the output of the above command

`docker run -it <imageID> or <image name> bash`

ex: `docker run -it rameshthoomu/peer bash` or `docker run -it 895b42b528a6 bash`

### 3. Saving changes inside Container

Above command takes you to the container, modify any file inside container ex: `core.yaml` file and press `CTRL + P + Q`. In docker, CTRL + P + Q runs the container in background mode or detached mode and automatically exit from the container.

Execute `docker ps` command to see the container running in detached mode. Take the container ID or container name and execute the below command

`docker commit <ContainerID> <NewImageName>`

Keep the above new Imagename in local_fabric.sh script and execute.
