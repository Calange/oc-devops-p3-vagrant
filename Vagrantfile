# 00 vagrant variables

vagrant_memory = ENV['VAGRANT_MEMORY'] || 3072
vagrant_cpus = ENV['VAGRANT_CPUS'] || 2
vagrant_host = ENV['VAGRANT_HOST'] || "oc-dev.local"

# 01 docker and other packages variables
# neovim_version = ENV['NEOVIM_VERSION'] || "0.1.7-4"
# ansible_version = ENV['ANSIBLE_VERSION'] || "2.2.1.0-2"
# dockerce_version = ENV['DOCKERCE_VERSION'] || "5:18.09.1~3-0~debian-stretch"
# dockercompose_version = ENV['DOCKERCOMPOSE_VERSION'] || "1.23.2"

# 02 pelican variables
# pythonpip_version = ENV['PYTHONPIP_VERSION'] || "9.0.1-2"

# 03 gitlab variables
# gitlab_edition = ENV['GITLAB_EDITION'] || "gitlab-ce"
# gitlab_version = ENV['GITLAB_VERSION'] || "11.8.0-ce.0"
# gitlabrunner_version = ENV['GITLABRUNNER_VERSION'] || "11.8.0"

# 04 jenkins variables
openjdk8_version = ENV['OPENJDK8_VERSION'] || "8u212-b03-2~deb9u1"
nginx_version = ENV['NGINX_VERSION'] || "1.10.3-1+deb9u2"
jenkins_version = ENV['JENKINS_VERSION'] || "2.164.3"

# vagrant configuration
Vagrant.configure("2") do |config|
  config.vm.provider "virtualbox" do |v|
    v.memory = vagrant_memory
    v.cpus = vagrant_cpus
  end
  config.vm.box = "debian/stretch64"
  config.vm.network "forwarded_port", guest: 80, host: 8000 # docker port
  # config.vm.network "forwarded_port", guest: 81, host: 8100 # pelican port
  # config.vm.network "forwarded_port", guest: 90, host: 9000 # gitlab port
  config.vm.network "forwarded_port", guest: 8080, host: 8080 # jenkins port
  config.vm.define :'oc-dev' do |t|
  end
  config.vm.hostname = vagrant_host
  config.vm.synced_folder ".", "/home/vagrant/oc-devops-p3-vagrant"
  config.vm.synced_folder "../oc-devops-p3-docker/", "/home/vagrant/oc-devops-p3-docker"
  # config.vm.synced_folder "../oc-devops-p4-pelican/", "/home/vagrant/oc-devops-p4-pelican"
  config.vm.synced_folder "../oc-devops-p8/", "/home/vagrant/oc-devops-p8"
  # config.vm.provision :shell, :path => "01-install-docker.sh", env: { "NEOVIM_VERSION" => neovim_version, "ANSIBLE_VERSION" => ansible_version, "DOCKERCE_VERSION" => dockerce_version, "DOCKERCOMPOSE_VERSION" => dockercompose_version}
  # config.vm.provision :shell, :path => "02-install-pelican.sh", env: { "PYTHONPIP_VERSION" => pythonpip_version }
  # config.vm.provision :shell, :path => "03-install-gitlab.sh", env: { "GITLAB_HOSTNAME" => vagrant_host, "GITLAB_EDITION" => gitlab_edition, "GITLAB_VERSION" => gitlab_version, "GITLABRUNNER_VERSION" => gitlabrunner_version }
  config.vm.provision :shell, :path => "04-install-jenkins.sh", env: { "OPENJDK8_VERSION" => openjdk8_version, "NGINX_VERSION" => nginx_version, "JENKINS_VERSION" => jenkins_version }
end