#!/bin/sh

printf "Downloading  Source code from Github ......."
git clone https://github.com/eldaraydayev/energi3.git
printf "DONE\n\n"

printf "Downloading Energi3 Tarbal file ......"
wget -q https://s3-us-west-2.amazonaws.com/download.energi.software/releases/energi3/v3.1.3/energi3-v3.1.3-linux-amd64.tgz
wget -q https://s3-us-west-2.amazonaws.com/download.energi.software/releases/energi3/v3.1.3/SHA256SUMS
printf "DONE\n\n"
echo "checking Energi3 checksum"
sha256sum -c --ignore-missing SHA256SUMS

printf "\nExtracting Energi3 TarBall file ......"
tar zxf ./energi3-v3.1.3-linux-amd64.tgz -C energi3
printf "DONE\n\n"

printf "Install Docker Security Scanner Trivy ........"
sudo apt-get install -y wget apt-transport-https gnupg lsb-release
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | sudo tee -a /etc/apt/sources.list.d/trivy.list
sudo apt-get update -y
printf "DONE\n\n"

printf "Installing Docker ........"

sudo apt install -y debootstrap docker-compose docker.io
sudo debootstrap focal linux > /dev/null
sudo tar -C linux -c . | sudo docker import - linux


(cd energi3; sudo docker build --tag energi3 .)
(cd energi3; sudo docker-compose up --detach)

printf "DONE\n\n"

printf "Checking Docker images ......."
sudo docker inspect energi3
printf ".... DONE"

printf "Cheking Docker image energi3"
sudo trivy image energi3

echo "Checking the Energi3 Node logs output"
sudo docker logs -f -n 100 energi3