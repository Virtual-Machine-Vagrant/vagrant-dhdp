require 'yaml'

current_dir   = File.dirname(File.expand_path(__FILE__))
configs       = YAML.load_file("#{current_dir}/config.yml")
custom_config = configs['configs']

Vagrant.configure(2) do |config|

	config.vm.box = "loispuig/debian-jessie-amd64"

	# Create a forwarded port mapping which allows access to a specific port
	# within the machine from a port on the host machine. In the example below,
	# accessing "localhost:8080" will access port 80 on the guest machine.
	config.vm.network "forwarded_port", guest: 80, host: 8080
	config.vm.network "forwarded_port", guest: 443, host: 8443

	# Create a private network, allows host-only access to the machine using a specific IP.
	config.vm.network "private_network", ip: "10.10.10.10"

	# Create a public network, which generally matched to bridged network.
	# Bridged networks make the machine appear as physical device on your network.
	#config.vm.network "public_network"

	# Share an additional folder to the guest VM.
	# The first argument is the path on the host to the actual folder.
	# The second argument is the path on the guest to mount the folder.
	# And the optional third argument is a set of non-required options.
	config.vm.synced_folder ".",             "/vagrant",          disabled: true
	config.vm.synced_folder "puppet",        "/vagrant/puppet",   create: true, owner: 'vagrant',  group: 'vagrant', mount_options: ["dmode=775,fmode=664"]
	config.vm.synced_folder "mysql-backups", "/var/mysql-backup", create: true, owner: 'vagrant',  group: 'vagrant', mount_options: ["dmode=777,fmode=666"]
	config.vm.synced_folder "log/mysql",     "/var/log/mysql",    create: true, owner: 'vagrant',  group: 'vagrant', mount_options: ["dmode=777,fmode=666"]
	config.vm.synced_folder "log/php",       "/var/log/php",      create: true, owner: 'vagrant',  group: 'vagrant', mount_options: ["dmode=777,fmode=666"]
	config.vm.synced_folder "log/apache2",   "/var/log/apache2",  create: true, owner: 'vagrant',  group: 'vagrant', mount_options: ["dmode=777,fmode=666"]
	config.vm.synced_folder "log/redis",     "/var/log/redis",    create: true, owner: 'vagrant',  group: 'vagrant', mount_options: ["dmode=777,fmode=666"]
	config.vm.synced_folder "letsencrypt",   "/etc/letsencrypt",  create: true
	config.vm.synced_folder "www/",          "/var/www",          create: true, owner: 'www-data', group: 'vagrant', mount_options: ["dmode=775,fmode=774"]

	config.vm.provider "virtualbox" do |vb|
		vb.name = "vagrant-"+custom_config['hostname']
		vb.gui = false
		vb.memory = 2048
		vb.cpus = 2
		# No matter how much CPU is used in the VM,
		# no more than 50% would be used on your own host machine
		#vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
	end

	# Warns to use Bindler
	unless Vagrant.has_plugin?("vagrant-hostmanager")
		puts "--- WARNING ---"
		puts "--- Plugin vagrant-hostmanager not installed, use command : vagrant plugin install vagrant-hostmanager"
	end

	if Vagrant.has_plugin?("vagrant-hostmanager")
		config.hostmanager.enabled = true
		config.hostmanager.manage_host = true
		config.hostmanager.ignore_private_ip = false
		config.hostmanager.include_offline = true
		config.vm.define 'vagrant-dhdp' do |node|
			node.vm.hostname = custom_config['hostname']+'.'+custom_config['domain']
			#node.vm.network :private_network, ip: '10.10.10.10'
			node.hostmanager.aliases = custom_config['aliases']
		end
  	end

  	# hostmanager provisioner
	config.vm.provision :hostmanager

	config.vm.provision "shell", inline: <<-SHELL
		cd /vagrant/puppet
		rm -Rf log/mysql/* log/php/* log/apache2/* log/redis/*
		LIBRARIANRESET=1
		if [ ! -d .librarian -o ${LIBRARIANRESET} -eq 1 ] ; then
			rm -Rf .tmp .librarian Puppetfile.lock
			librarian-puppet install --clean --verbose
		#else
			#librarian-puppet outdated | cut -d ' ' -f 1 | xargs librarian-puppet update $1 --verbose
			#librarian-puppet update puppet-hdp --verbose
		fi
	SHELL

	config.vm.provision "puppet" do |puppet|
		puppet.manifests_path = "puppet"
		puppet.manifest_file = "init.pp"
		puppet.module_path = "puppet/modules"
		puppet.environment_path = "environments"
    	puppet.environment = "puppet"
		puppet.options = "--verbose --debug" #--no-stringify_facts --trusted_node_data
		puppet.facter = {
			"custom_config" => custom_config
        }
	end
end