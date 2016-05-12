Vagrant.configure(2) do |config|

	config.vm.box = "loispuig/debian-jessie-amd64"

	# Create a forwarded port mapping which allows access to a specific port
	# within the machine from a port on the host machine. In the example below,
	# accessing "localhost:8080" will access port 80 on the guest machine.
	#config.vm.network "forwarded_port", guest: 80, host: 8080
	#config.vm.network "forwarded_port", guest: 443, host: 8443

	# Create a private network, which allows host-only access to the machine
	# using a specific IP.
	config.vm.network "private_network", ip: "10.10.10.10"

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

	config.vm.provider "virtualbox" do |vb|
		vb.gui = false
		vb.memory = "1024"
	end

	config.vm.provision "shell", inline: <<-SHELL
		cd /vagrant/puppet && librarian-puppet install --verbose #--clean
	SHELL

	config.vm.provision "puppet" do |puppet|
		puppet.manifests_path = "puppet"
		puppet.manifest_file = "init.pp"
		puppet.module_path = "puppet/modules"
		puppet.options = "--debug --verbose"
		#puppet.facter = {
		#	"vagrant" => "1",
		#}
	end
end