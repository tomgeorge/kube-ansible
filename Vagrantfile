
# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "ubuntu/trusty64"



  config.vm.provision "shell", inline: "apt-get update && apt-get install -y gcc build-essential software-properties-common make git python3"
  config.vm.provision "shell", inline: "add-apt-repository ppa:neovim-ppa/unstable"
  config.vm.provision "shell", inline: "add-apt-repository ppa:ansible/ansible"
  config.vm.provision "shell", inline: "apt-get update && apt-get install -y neovim ansible"
  config.vm.provision "shell", inline: "git clone https://github.com/tomgeorge/dotfiles"
  config.vm.provision "shell", inline: "git clone https://github.com/tomgeorge/vimfiles /home/vagrant/vim"

  # create private network
  #config.vm.network "private_network", ip: "192.168.0.100", netmask: "255.255.0.0"
  config.vm.network "public_network", ip: "10.0.1.142"
  config.vm.provider :virtualbox do |vb|
  	vb.customize ["modifyvm", :id, "--nicpromisc2", "allow-all"]
	vb.memory = 1024
	vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
	vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
  end
  config.vm.synced_folder ".", "/home/vagrant/sync", disabled: true
  config.vm.synced_folder "~/git", "/home/vagrant/git"
end
