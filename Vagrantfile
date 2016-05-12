# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

	config.vm.box = "loispuig/debian-jessie-amd64"

	# Create a forwarded port mapping which allows access to a specific port
	# within the machine from a port on the host machine. In the example below,
	# accessing "localhost:8080" will access port 80 on the guest machine.
	config.vm.network "forwarded_port", guest: 80, host: 8080
	config.vm.network "forwarded_port", guest: 443, host: 8443

	# Create a private network, which allows host-only access to the machine
	# using a specific IP.
	#config.vm.network "private_network", ip: "10.0.9.2"

	# Create a public network, which generally matched to bridged network.
	# Bridged networks make the machine appear as another physical device on
	# your network.
	#config.vm.network "public_network"

	# Share an additional folder to the guest VM. The first argument is
	# the path on the host to the actual folder. The second argument is
	# the path on the guest to mount the folder. And the optional third
	# argument is a set of non-required options.
	#config.vm.synced_folder "log/redis", "/var/log/redis", create: true, owner: 'redis', group: 'redis'
	#config.vm.synced_folder "log/mysql", "/var/log/mysql", create: true, owner: 'mysql', group: 'adm'
	#config.vm.synced_folder "log/php", "/var/log/php", create: true, owner: 'www-data', group: 'www-data'
	#config.vm.synced_folder "log/apache2", "/var/log/apache2", create: true, owner: 'www-data', group: 'www-data'
	config.vm.synced_folder "www/", "/var/www", create: true, owner: 'www-data', group: 'www-data'
	

	# Provider-specific configuration so you can fine-tune various
	# backing providers for Vagrant. These expose provider-specific options.
	# Example for VirtualBox:

	config.vm.provider "virtualbox" do |vb|
		vb.gui = false
		vb.memory = "1024"
	end

	# View the documentation for the provider you are using for more
	# information on available options.

	# Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
	# such as FTP and Heroku are also available. See the documentation at
	# https://docs.vagrantup.com/v2/push/atlas.html for more information.
	# config.push.define "atlas" do |push|
	#   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
	# end

	config.vm.provision "shell", inline: <<-SHELL
		cd /vagrant/puppet && librarian-puppet install # --clean --verbose
	SHELL

	config.vm.provision "puppet" do |puppet|
		puppet.manifests_path = "puppet"
		puppet.manifest_file = "init.pp"
		puppet.module_path = "puppet/modules"
		puppet.options = "--debug --verbose"
		puppet.facter = {
			"vagrant" => "1",
		}
	end
end