#!/usr/bin/env bash

set -e # exit script immediately on first error

echo -e "\e[34m\e[1m=== Update current packages ==="
apt-get update
echo -e "\e[34m\e[1m=== Neovim installation ==="
apt-get install -y neovim
echo -e "\e[34m\e[1m=== Ansible installation ==="
apt-get install -y ansible
echo -e "\e[34m\e[1m=== Docker CE installation ==="
apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg --output docker_gpg
apt-key add docker_gpg && rm -f docker_gpg
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
apt-get update
apt-get install -y docker-ce
echo -e "\e[34m\e[1m=== Check if Neovim, Ansible and Docker CE are present ==="
dpkg-query -l neovim ansible docker-ce
echo -e "\e[34m\e[1m=== Build docker image: oc-devops-p3-docker ==="
cd oc-devops-p3-docker
docker build -t oc-devops-p3-docker .
echo -e "\e[34m\e[1m=== Run docker image: oc-devops-p3-docker ==="
docker run --name mywebsite.com -v /home/vagrant/oc-devops-p3-docker/mywebsite.com:/usr/share/nginx/html:ro -d -p 80:80 oc-devops-p3-docker
