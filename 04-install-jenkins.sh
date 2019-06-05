#!/usr/bin/env bash

set -e

echo -e "\e[34m\e[1m=== Update current packages ==="
apt-get update

echo -e "\e[34m\e[1m=== Git ($GIT_VERSION) installation ==="
apt-get install -y git="$GIT_VERSION"

echo -e "\e[34m\e[1m=== Openjdk ($OPENJDK8_VERSION) installation ==="
apt-get install -y openjdk-8-jdk-headless="$OPENJDK8_VERSION"

# echo -e "\e[34m\e[1m=== Nginx ($NGINX_VERSION) installation ==="
# apt-get install -y nginx="$NGINX_VERSION"

echo -e "\e[34m\e[1m=== Jenkins ($JENKINS_VERSION) installation ==="
wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
apt-get update
apt-get install -y jenkins="$JENKINS_VERSION"
sleep 10

echo -e "\e[34m\e[1m=== Jenkins initialAdminPassword: $(cat /var/lib/jenkins/secrets/initialAdminPassword) ==="
