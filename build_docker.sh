#!/bin/sh
wget https://s3-us-west-2.amazonaws.com/download.energi.software/releases/energi3/v3.1.3/energi3-v3.1.3-linux-amd64.tgz
tar zxvf ./energi3-v3.1.3-linux-amd64.tgz

sudo apt install -y debootstrap docker-compose docker.io
sudo debootstrap focal linux > /dev/null
sudo tar -C linux -c . | sudo docker import - linux
sudo COMPOSE_PROJECT_NAME=energi ENERGI_VERSION=v3.1.3 STAKER_HOME=/home/nrgstaker ENERGI_BIN=/usr/local/bin/energi ENERGI_CORE_DIR=${STAKER_HOME}/.energi_core docker build --tag energi3 .
