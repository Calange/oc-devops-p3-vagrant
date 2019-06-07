#!/usr/bin/env bash

set -e

echo -e "\e[34m\e[1m=== Update current packages ==="
apt-get update

echo -e "\e[34m\e[1m=== Neovim ($NEOVIM_VERSION) installation ==="
apt-get install -y neovim="$NEOVIM_VERSION"

echo -e "\e[34m\e[1m=== Ansible ($ANSIBLE_VERSION) installation ==="
apt-get install -y ansible="$ANSIBLE_VERSION"

echo -e "\e[34m\e[1m=== Docker CE ($DOCKERCE_VERSION) installation ==="
apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg --output docker_gpg
apt-key add docker_gpg && rm -f docker_gpg
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
apt-get update
apt-get install -y docker-ce="$DOCKERCE_VERSION"

echo -e "\e[34m\e[1m=== Docker-compose ($DOCKERCOMPOSE_VERSION) installation ==="
curl -L "https://github.com/docker/compose/releases/download/$DOCKERCOMPOSE_VERSION/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

echo -e "\e[34m\e[1m=== Check if Neovim, Ansible, Docker CE and Docker-compose are present ==="
dpkg-query -l neovim ansible docker-ce
docker-compose --version

echo -e "\e[34m\e[1m=== Docker-compose up: oc-devops-p8-prestashop ==="
cd oc-devops-p8-prestashop
docker-compose up -d --build
