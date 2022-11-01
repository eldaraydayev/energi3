# DevOps Chalenge for Enegri

## 1) Docker Whale:

Write a Dockerfile to run Energi v3.1.2 in a container. It should somehow verify the checksum of the downloaded release
(there’s no need to build the project), run as a normal user, it should run the client, and print its output to the console.
https://wiki.energi.world/en/downloads/core-node
The build should be security conscious, and ideally pass a container image security test such as ECR, or Trivy. [20 pts]

$ wget https://s3-us-west-2.amazonaws.com/download.energi.software/releases/energi3/v3.1.3/energi3-v3.1.3-linux-amd64.tgz
$ tar zxvf ./energi3-v3.1.3-linux-amd64.tgz
$ ls -alF 
Output:
energi3-v3.1.3-linux-amd64/bin/energi3
energi3-v3.1.3-linux-amd64/COPYING


wget https://s3-us-west-2.amazonaws.com/download.energi.software/releases/energi3/v3.1.3/SHA256SUMS
$ sha256sum -c --ignore-missing SHA256SUMS

Output:
energi3-v3.1.3-linux-amd64.tgz: OK

### Preparing docker image steps:

$ sudo apt install -y debootstrap docker-compose docker.io
$ sudo debootstrap focal linux > /dev/null
$ sudo tar -C linux -c . | sudo docker import - linux

sha256:ea13c4966dec260aa32235ffc933f1bd97102424cdb773d57bedb2960ca03a13

$ sudo docker image ls -a
REPOSITORY   TAG       IMAGE ID       CREATED          SIZE
focal        latest    976f7b7a9ed8   37 seconds ago   322MB

#### Checking vanila Linux docker images:

$ sudo docker run focal cat /etc/lsb-release
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=20.04
DISTRIB_CODENAME=focal
DISTRIB_DESCRIPTION="Ubuntu 20.04 LTS"


git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/eldaraydayev/energi3.git
git push -u origin main


git clone https://github.com/eldaraydayev/energi3.git
sudo COMPOSE_PROJECT_NAME=energi ENERGI_VERSION=v3.1.3 STAKER_HOME=/home/nrgstaker ENERGI_BIN=/usr/local/bin/energi ENERGI_CORE_DIR=${STAKER_HOME}/.energi_core docker build --tag energi3 .
sudo . ./.env docker-compose exec /usr/local/bin/energi --datadir /home/nrgstaker/.energi_core attach
docker-compose up --detach