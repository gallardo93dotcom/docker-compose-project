#!/bin/sh

set -e

# Update and Upgrade
apt update && apt upgrade

#Install dependencies
apt install apt-transport-https ca-certificates curl software-properties-common -y
wget https://download.docker.com/linux/debian/gpg 
sudo apt-key add gpg

#add repo
echo "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee -a /etc/apt/sources.list.d/docker.list

#install docker-ce and start/enable
apt update && apt upgrade
apt install docker-ce -y
systemctl start docker
systemctl enable docker

#install docker-compose 1.16.1
curl -L https://github.com/docker/compose/releases/download/1.16.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
