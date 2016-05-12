Please follow below commands before execute local_fabric.sh script in outside vagrant environment.

(Below commands applicable only for non-vagrant environment: tested in Linux 14.04 LTS version)

- sudo ufw status
- sudo ufw disable

Incase if peers are not launching please clear iptables rules and re-start docker daemon.

####Launching peers in local machine (Inside and Outside Vagrant environments)

Copy or curl `local_fabric.sh` [**local_fabric.sh**](https://github.com/rameshthoomu/obc-test/blob/network_spinup/localpeersetup/local_fabric.sh) file into local machine and follow below instructions to run the script.

To curl, click on Raw link and copy the link from address bar and curl it or copy and paste the below link in your local machine.

Example:

curl -L https://raw.githubusercontent.com/rameshthoomu/obc-test/network_spinup/localpeersetup/local_faric.sh?token=AQPtBmIVdXR6py4hpc9L63TuWgsUs_Y9ks5XMlOHwA%3D%3D -o local_fabric.sh

*Follow below steps:*

1. Make sure openblockchain/baseimage:latest Docker Image is available in your system. (Please see below section to generate baseImage)
2. Make sure Docker Daemon is up and running. If not, please execute `sudo service docker start`
3. Execute `chmod +x local_fabric.sh` `dos2unix ./local_fabric.sh` to make sure file is good to execute in unix environment.
4. Execute `./local_fabric.sh -n 4 -s` (Enabled Security, Privacy with Consensus for 4 peers)
5. To launch peers with security and without Consensus, please comment out `CONSENSUS=pbft` and `PBFT_MODE=batch` lines or change the value to noops in `local_fabric.sh`.

-n indicates number of peers you want 
-s indicates running peers with Security, Privacy and Consensus enabled. (If you don't pass any arguments, by default, script launches 5 peers without security, Privacy and Consensus) 

**Pulling Docker Images:**

Above script automatically pulls latest Docker Images of Hyperledger-peer and membersrvc from Docker Hub (Please check the commit number associated the latest tag in rameshthoomu/peer and rameshthoomu/membersrvc).

**Building openblockchain/baseimage:latest Image** (Outside vagrant)

- Perform `git pull https://github.com/hyperledger/fabric.git master`
- run `cd $GOPATH/src/gihub.com/hyperledger/fabric/scripts/provision`
- run `./docker.sh 0.0.9` (this will generate openblockchain/baseimage:latest Image)

**Building openblockchain/baseimage:latest Image** (Inside vagrant)

- Perform `vagrant halt/destroy`
- run `vagrant up` command

###Useful Docker Commands:

1. Kill all containers
  - `docker rm $(docker kill $(docker ps -aq))` (user rm -f to force kill)
2. Remove all exited containers
  - `docker ps -aq -f status=exited | xargs docker rm`
3. Remove all Images except 'openblockchain/baseimage'
  - `docker rmi $(docker images | grep -v 'openblockchain/baseimage' | awk {'print $3'})`
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
