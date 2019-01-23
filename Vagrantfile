Vagrant.configure("2") do |config|
  config.vm.box = "debian/stretch64"
  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
    # installation de l'éditeur de texte
    apt-get install -y neovim
    # installation d'ansible
    apt-get install -y ansible
    # installation de docker-ce
    apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common
    curl -fsSL https://download.docker.com/linux/debian/gpg --output docker_gpg
    apt-key add docker_gpg && rm -f docker_gpg
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
    apt-get update
    apt-get install -y docker-ce
  SHELL
end
