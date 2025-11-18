# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
ENV["LC_ALL"] = "es_ES.UTF-8"

Vagrant.configure("2") do |config|

  config.vm.box = "valvarezg/OracleLinux9.6"
  config.vm.boot_timeout=1200
  config.vm.synced_folder "/mnt/c", "/vagrant", disabled: false
  config.ssh.username = "vagrant"          # Default user
  config.ssh.password="vagrant"

#$default_network_interface = `ip route | awk '/^default/ {printf "%s", $5; exit 0}'`
N = 2
  (1..N).each do |machine_id|
       config.vm.define "machine#{machine_id}" do |machine|
           machine.vm.hostname = "OracleLinux9-#{machine_id}"
           machine.vm.network "private_network", ip: "192.168.56.#{200+machine_id}"
          # machine.vm.network "public_network", bridge: "Intel PRO/1000 MT Desktop (82540EM)"
	
		   machine.vm.provider "virtualbox" do |vb|
			  vb.name = "OracleLinux9-#{machine_id}"
			  vb.memory = "2048"
			  vb.cpus = 1
			  #Creacion de discos
			  if machine_id==1
		         unless File.exist?('./secondDisk.vdi')
                   vb.customize ['createhd', '--filename', './secondDisk.vdi', '--variant', 'Fixed', '--size', 2 * 1024]
                 end
                 unless File.exist?('./thirdDisk.vdi')
                   vb.customize ['createhd', '--filename', './thirdDisk.vdi', '--variant', 'Fixed', '--size', 2 * 1024]
                 end

			    vb.customize ['storageattach', :id,  '--storagectl', 'IDE Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', './secondDisk.vdi']
                vb.customize ['storageattach', :id,  '--storagectl', 'IDE Controller', '--port', 1, '--device', 1, '--type', 'hdd', '--medium', './thirdDisk.vdi']
              end  
		      #config.vm.provision "shell", privileged: false, path: "./scripts/base.sh"
			  #config.vm.provision "shell", privileged: false, path: "./scripts/virtualbox.sh"
			  #config.vm.provision "shell", privileged: false, path: "./scripts/vagrant.sh"
			  #config.vm.provision "shell", privileged: false, path: "./scripts/provision.sh"
			  #config.vm.provision "shell", privileged: false, path: "./scripts/cleanup.sh"
			  #config.vm.provision "shell", privileged: false, path: "./scripts/zerodisk.sh"
		   end
		end 
    end
	  
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
  # documentation for more information about their specific syntax and use.
   #config.vm.provision "shell", inline: <<-SHELL
  #	 mkdir -p /home/vagrant/.ssh
	#   echo "AAAAB3NzaC1yc2EAAAADAQABAAACAQDf7k0LL6YOHMSpxM2VYIQ3bx2XAq+kZJGriUHgQSVRhKG/TCBrOcpobw7ctk56yaRQpN9BrvWtwYWYes4tpPG9nBdP4gu4mQEEXITlUW9fkNkUQGftvtIZtwppIkSt/It8SHtVAxXelSLTJKOVpH7VO1vJYZe+Sv78rLADrArMeXkelVJs2JGpqFQY0YzGw+o70gxP1nSlqo5MS1wzS+Hq+hTo9m4IQzpU7fgEFYJmCzi6DX8LLpQZoqKCFyWD0fdMrtr7vEPFS17bKIdxJ1MkPNatOIYRmkH2SEOZAW+rHkxWxAxq+LD6zJMRM33hG9SLQ2J2R/1OWc1FWRFz+82JeDt1Lah4MqF6FJBrNntx0ekf+vdeQgIZZWUTvGFqte2KLYvVEX415OXHAjIM7DBM4ebdhE8PNj/fT8mh8iECpqpWIgQ06YWS/3MkVsIXUsyyeiBy7hLI1K1pdjNYXN1mIcna7MU6MxHoxBnrQft10RDJkFbYYoPfmPVOF+SZej6IH39eemhKa3kr5gQnXXVFpOugDDkfUejOgHgVrSVOMz6zPPSi9+be2GYY4L/7V9L5G4rP72sELwigbBs8YFDbecHpkPoSeKs0eUeYg0yRfbUzKum2jkxUuVbJY77lCfsOsPD4Ok/Z4I9JwqjX+TW8k837D2p6fbHLF2xsfcIuFw== plexus\victor.alvarezgonzal@PLX10749-002" > /home/vagrant/.ssh/authorized_keys
	#   chown -R vagrant:vagrant /home/vagrant/.ssh
	#   chmod 600 /home/vagrant/.ssh/authorized_keys
  # SHELL
end
