# packages version variables
neovim_version = ENV['NEOVIM_VERSION'] || "0.1.7-4"
ansible_version = ENV['ANSIBLE_VERSION'] || "2.2.1.0-2"
dockerce_version = ENV['DOCKERCE_VERSION'] || "5:18.09.1~3-0~debian-stretch"
dockercompose_version = ENV['DOCKERCOMPOSE_VERSION'] || "1.23.2"

# gitlab variables
gitlab_memory = ENV['GITLAB_MEMORY'] || 3072
gitlab_cpus = ENV['GITLAB_CPUS'] || 2
gitlab_swap = ENV['GITLAB_SWAP'] || 0
gitlab_host = ENV['GITLAB_HOST'] || "oc-dev.local"
gitlab_edition = ENV['GITLAB_EDITION'] || "community"
gitlab_version = ENV['GITLAB_VERSION'] || "11.8.0-ce.0"
gitlab_private_network = ENV['GITLAB_PRIVATE_NETWORK'] || 0

# vagrant configuration
Vagrant.configure("2") do |config|
  config.vm.provider "virtualbox" do |v|
    v.memory = gitlab_memory
    v.cpus = gitlab_cpus
  end
  config.vm.box = "debian/stretch64"
  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", guest: 81, host: 8081
  config.vm.network "private_network", type: "dhcp" if gitlab_private_network == '1'
  config.vm.define :'oc-dev' do |t|
  end
  config.vm.hostname = gitlab_host
  config.vm.synced_folder ".", "/home/vagrant/oc-devops-p3-vagrant"
  config.vm.synced_folder "../oc-devops-p3-docker/", "/home/vagrant/oc-devops-p3-docker"
  config.vm.provision :shell, :path => "provision.sh", env: { "NEOVIM_VERSION" => neovim_version, "ANSIBLE_VERSION" => ansible_version, "DOCKERCE_VERSION" => dockerce_version, "DOCKERCOMPOSE_VERSION" => dockercompose_version}
  config.vm.provision :shell, :path => "install-gitlab.sh", env: { "GITLAB_SWAP" => gitlab_swap, "GITLAB_HOSTNAME" => gitlab_host, "GITLAB_EDITION" => gitlab_edition, "GITLAB_VERSION" => gitlab_version }
end