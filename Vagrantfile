Vagrant.configure("2") do |config|
  config.vm.box = "debian/stretch64"
  config.vm.define :'oc-dev' do |t|
  end
  config.vm.hostname = "oc-dev"
  config.vm.provision "shell", inline: <<-SHELL
    echo "\e[34m\e[1m=== Mise à jour de la liste des paquets disponibles ==="
    apt-get update
    echo "\e[34m\e[1m=== Installation de l'éditeur de texte Neovim ==="
    apt-get install -y neovim
    echo "\e[34m\e[1m=== Installation d'Ansible ==="
    apt-get install -y ansible
    echo -e "\e[34m\e[1m=== Installation de Docker CE ==="
    apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common
    curl -fsSL https://download.docker.com/linux/debian/gpg --output docker_gpg
    apt-key add docker_gpg && rm -f docker_gpg
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
    apt-get update
    apt-get install -y docker-ce
    echo -e "\e[34m\e[1m=== Vérification de l'installation de Neovim, Ansible et Docker CE ==="
    dpkg-query -l neovim ansible docker-ce
  SHELL
end