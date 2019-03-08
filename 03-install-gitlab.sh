#!/usr/bin/env bash

set -e

export DEBIAN_FRONTEND=noninteractive

rewrite_hostname() {
    sed -i -e "s,^external_url.*,external_url 'http://${GITLAB_HOSTNAME}:90/'," /etc/gitlab/gitlab.rb
}

# install tools to automate
apt-get -y update
apt-get -y install debconf-utils curl

# install dependencies
echo "postfix postfix/main_mailer_type select Internet Site" | debconf-set-selections
echo "postfix postfix/mailname string $GITLAB_HOSTNAME" | debconf-set-selections
apt-get -y install openssh-server postfix

# download omnibus-gitlab package with apt
echo "Setting up Gitlab deb repository ..."
curl https://packages.gitlab.com/install/repositories/gitlab/"${GITLAB_EDITION}"/script.deb.sh | sudo bash
echo "Installing ${GITLAB_EDITION} via apt ..."
apt-get install -y "${GITLAB_EDITION}"="${GITLAB_VERSION}"

# fix the config and reconfigure
cp /home/vagrant/oc-devops-p3-vagrant/gitlab.rb /etc/gitlab/gitlab.rb
rewrite_hostname
gitlab-ctl reconfigure

# install gitlab-runner
echo "Setting up Gitlab-runner deb repository ..."
curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh | sudo bash
echo "Installing gitlabrunner via apt ..."
apt-get install -y gitlab-runner="${GITLABRUNNER_VERSION}"

# check install
echo -e "\e[34m\e[1m=== Check if Gitlab CE and Gitlab Runner are present ==="
dpkg-query -l gitlab-ce gitlab-runner

# ready to login
echo -e "\e[34m\e[1m Login at http://localhost:9000/ on your host machine, username 'root'. Password will be reset on first login."
echo -e "\e[34m\e[1m Don't forget to register a runner!"
