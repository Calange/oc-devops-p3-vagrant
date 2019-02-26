Vagrant.configure("2") do |config|
  config.vm.provider "virtualbox" do |v|
    v.memory = 4096
    v.cpus = 4
  end
  config.vm.box = "debian/stretch64"
  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", guest: 8000, host: 8000
  config.vm.define :'oc-dev' do |t|
  end
  config.vm.hostname = "oc-dev"
  config.vm.synced_folder "../oc-devops-p3-docker/", "/home/vagrant/oc-devops-p3-docker"
  config.vm.provision :shell, :path => "provision.sh"
end