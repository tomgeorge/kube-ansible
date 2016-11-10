
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
  config.vm.box = "centos/7"


  config.vm.provision "shell", inline: "yum makecache fast"
  config.vm.provision "shell", inline: "yum install -y yum-utils"
  config.vm.provision "shell", inline: "package-cleanup -y --cleandupes"
  config.vm.provision "shell", inline: "yum install -y gcc gcc-c++ make git python-devel vim"
  config.vm.provision "shell", inline: "curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && python get-pip.py" 
  config.vm.provision "shell", inline: "pip install paramiko PyYAML Jinja2 httplib2 six"
  config.vm.provision "shell", inline: "git clone https://github.com/ansible/ansible --recursive"
  config.vm.provision "shell", inline: "cd ansible && source ./hacking/env-setup"

  # create private network
  #config.vm.network "private_network", ip: "192.168.0.100", netmask: "255.255.0.0"
  #config.vm.network "public_network", ip: "10.0.1.142"
  config.vm.provider :virtualbox do |vb|
  	vb.customize ["modifyvm", :id, "--nicpromisc2", "allow-all"]
	vb.memory = 512
  end
  config.vm.synced_folder ".", "/home/vagrant/sync", disabled: true
end
