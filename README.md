# OC-DEVOPS-P3-VAGRANT

## Requirements

Clone the repo oc-devops-p3-docker:

```sh
$ git clone https://github.com/Calange/oc-devops-p3-docker ../
```

## Installation

MacOS:

```sh
$ brew cask install virtualbox
$ brew cask install vagrant
$ brew cask install vagrant-manager
$ vagrant plugin install vagrant-vbguest
```

## Usage

*For development usage the folder `mywebsite.com` is synced with the local folder on host but you can disable this to have prod ready environment*

[![asciicast](https://asciinema.org/a/226229.png)](https://asciinema.org/a/226229)

# OC-DEVOPS-P4-VAGRANT

## Gitlab

The installation is inspired by this repo:

https://github.com/tuminoid/gitlab-installer

Gitlab.rb default configuration:

https://gitlab.com/gitlab-org/omnibus-gitlab/blob/master/files/gitlab-config-template/gitlab.rb.template

How to register a runner:

https://docs.gitlab.com/runner/register/index.html

[![asciicast](https://asciinema.org/a/233326.png)](https://asciinema.org/a/233326)