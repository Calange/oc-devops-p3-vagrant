#!/usr/bin/env bash

set -e

export DEBIAN_FRONTEND=noninteractive

fatal() {
    echo "fatal: $@" >&2
}

check_for_root() {
    if [[ $EUID != 0 ]]; then
        fatal "need to be root"
        exit 1
    fi
}

check_for_gitlab_rb() {
    if [[ ! -e /home/vagrant/oc-devops-p3-vagrant/gitlab.rb ]]; then
        fatal "gitlab.rb not found at /vagrant"
        exit 1
    fi
}

set_gitlab_edition() {
    if [[ $GITLAB_EDITION == "community" ]]; then
        GITLAB_PACKAGE=gitlab-ce
    elif [[ $GITLAB_EDITION == "enterprise" ]]; then
        GITLAB_PACKAGE=gitlab-ee
    else
        fatal "\"${GITLAB_EDITION}\" is not a supported GitLab edition"
        exit 1
    fi
}

set_apt_pdiff_off() {
    echo 'Acquire::PDiffs "false";' >/etc/apt/apt.conf.d/85pdiff-off
}

install_swap_file() {
    if [[ $GITLAB_SWAP -gt 0 ]]; then
        echo "Creating swap file of ${GITLAB_SWAP}G size"
        SWAP_FILE=/.swap.file
        dd if=/dev/zero of=$SWAP_FILE bs=1G count="$GITLAB_SWAP"
        mkswap $SWAP_FILE
        echo "$SWAP_FILE none swap sw 0 0" >>/etc/fstab
        chmod 600 $SWAP_FILE
        swapon -a
    else
        echo "Skipped swap file creation due 'GITLAB_SWAP' set to 0"
    fi
}

rewrite_hostname() {
    sed -i -e "s,^external_url.*,external_url 'http://${GITLAB_HOSTNAME}:81/'," /etc/gitlab/gitlab.rb
}

# All commands expect root access.
check_for_root

# Check that the GitLab edition which is defined is supported and set package name
set_gitlab_edition

# Check for configs
check_for_gitlab_rb

# install swap file for more memory
install_swap_file

# install tools to automate this install
apt-get -y update
apt-get -y install debconf-utils curl

# install the few dependencies we have
echo "postfix postfix/main_mailer_type select Internet Site" | debconf-set-selections
echo "postfix postfix/mailname string $GITLAB_HOSTNAME" | debconf-set-selections
apt-get -y install openssh-server postfix

# download omnibus-gitlab package with apt
echo "Setting up Gitlab deb repository ..."
set_apt_pdiff_off
curl https://packages.gitlab.com/install/repositories/gitlab/${GITLAB_PACKAGE}/script.deb.sh | sudo bash
echo "Installing ${GITLAB_PACKAGE} via apt ..."
apt-get install -y ${GITLAB_PACKAGE}="${GITLAB_VERSION}"

# fix the config and reconfigure
cp /home/vagrant/oc-devops-p3-vagrant/gitlab.rb /etc/gitlab/gitlab.rb
rewrite_hostname
gitlab-ctl reconfigure

# install gitlab-runner
apt-get install -y gitlab-runner=11.8.0

# wget -O /usr/local/bin/gitlab-runner https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64
# chmod +x /usr/local/bin/gitlab-runner
# useradd --comment 'GitLab Runner' --create-home gitlab-runner --shell /bin/bash
# gitlab-runner install --user=gitlab-runner --working-directory=/home/gitlab-runner
# gitlab-runner start

echo -e "\e[34m\e[1m=== Check if Neovim, Ansible, Docker CE and Docker-compose are present ==="
dpkg-query -l gitlab-ce gitlab-runner

# done
echo -e "\e[34m\e[1m Login at http://localhost:8081/ on your host machine, username 'root'. Password will be reset on first login."
