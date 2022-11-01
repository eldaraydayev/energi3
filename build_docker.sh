#!/bin/sh

git clone https://github.com/eldaraydayev/energi3.git

wget https://s3-us-west-2.amazonaws.com/download.energi.software/releases/energi3/v3.1.3/energi3-v3.1.3-linux-amd64.tgz
wget https://s3-us-west-2.amazonaws.com/download.energi.software/releases/energi3/v3.1.3/SHA256SUMS

echo "checking Energi3 checksum"
sha256sum -c --ignore-missing SHA256SUMS

tar zxvf ./energi3-v3.1.3-linux-amd64.tgz


echo "Installing Docker"

sudo apt install -y debootstrap docker-compose docker.io
sudo debootstrap focal linux > /dev/null
sudo tar -C linux -c . | sudo docker import - linux
sudo docker build --tag energi3 .
sudo docker-compose up --detach