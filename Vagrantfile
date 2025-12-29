# -*- mode: ruby -*-
# vi: set ft=ruby :

ENV["LC_ALL"] = "es_ES.UTF-8"

Vagrant.configure("2") do |config|
  
  config.vm.box = "valvarezg/OracleLinux9.6"
  config.ssh.insert_key=false
  config.ssh.forward_agent = true
  config.vm.boot_timeout=1200
  #config.vm.synced_folder "/mnt/c", "/vagrant", disabled: false
  config.vm.synced_folder "/mnt/d/Software Oracle", "/software/", disabled: false
  #config.ssh.username = "vagrant"          # Default user
  #config.ssh.password="vagrant"

#$default_network_interface = `ip route | awk '/^default/ {printf "%s", $5; exit 0}'`

N = 2
  (1..N).each do |machine_id|
     config.vm.define "machine#{machine_id}" do |machine|
       machine.vm.hostname = "host0#{machine_id}"
       machine.vm.network "private_network", ip: "192.168.2.#{100+machine_id}", virtualbox__intnet: "PrivateNetwork"
       machine.vm.network "private_network", ip: "192.168.3.#{200+machine_id}", virtualbox__intnet: "PrivateNetwork"
       machine.vm.network "public_network", bridge: "Realtek 8852CE WiFi 6E PCI-E NIC" 
		   #config.vm.network "private_network",ip: "192.168.56.20",virtualbox__hostonly: "vboxnet0" --host-only

       machine.vm.provider "virtualbox" do |vb|
		    vb.name = "OracleLinux9-#{machine_id}"
		    vb.memory = "2048"
		    vb.cpus = 2

         # Define disks to create and attach
         disks = [
           { size: 1024, name: "disk11.vdi" }, # 1GB
           { size: 1024, name: "disk12.vdi" }, # 1GB
           { size: 1024, name: "disk13.vdi" }, # 1GB
           { size: 1024, name: "disk14.vdi" }, # 1GB
           { size: 1024, name: "disk15.vdi" }, # 1GB
           { size: 1024, name: "disk16.vdi" }  # 1GB
         ]

         # Using SATA controller here, change 'SATA' if you prefer 'IDE'
         vb.customize ["storagectl",:id,"--name","SATA","--add","sata","--portcount","6"] 

         # Loop through disks to create and attach
         disks.each_with_index do |disk, index|
           # Use a unique port for each disk (e.g., 1, 2, 3, 4 for IDE/SATA)
           port_num = index + 1

           if machine_id==1 
             # Create the disk image if it doesn't exist
             unless File.exist?(disk[:name])
               vb.customize ["createhd", "--filename", disk[:name], "--size", disk[:size], "--variant", "Fixed"]
               vb.customize ["modifymedium",disk[:name],"--type","shareable"]
             end
             
           end

           # Attach the disk to the VM
           vb.customize ["storageattach", :id, "--storagectl", "SATA", "--port", port_num, "--device", 0, "--type", "hdd", "--medium", disk[:name]]
         end
       end

     end

   end
   config.vm.provision "shell", inline: "echo 'Init Provisioning VM ...'"	
   config.vm.provision "shell", privileged: false, path: "./scripts/base.sh"
   config.vm.provision "shell", privileged: false, path: "./scripts/partition_disk.sh"
   config.vm.provision "shell", inline: "echo 'End Provisioning VM ...'"

   config.vm.provision "shell", inline: <<-SHELL
     mkdir -p /u01/app/oracle/product/19.0.0/dbhome_1
     mkdir -p /u02/oradata
     chown -R oracle:oinstall /u01 /u02
     chmod -R 775 /u01 /u02
     setenforce Permissive
     systemctl stop firewalld
     systemctl disable firewalld
   #	 mkdir -p /home/vagrant/.ssh
	 #   echo "AAAAB3NzaC1yc2EAAAADAQABAAACAQDf7k0LL6YOHMSpxM2VYIQ3bx2XAq+kZJGriUHgQSVRhKG/TCBrOcpobw7ctk56yaRQpN9BrvWtwYWYes4tpPG9nBdP4gu4mQEEXITlUW9fkNkUQGftvtIZtwppIkSt/It8SHtVAxXelSLTJKOVpH7VO1vJYZe+Sv78rLADrArMeXkelVJs2JGpqFQY0YzGw+o70gxP1nSlqo5MS1wzS+Hq+hTo9m4IQzpU7fgEFYJmCzi6DX8LLpQZoqKCFyWD0fdMrtr7vEPFS17bKIdxJ1MkPNatOIYRmkH2SEOZAW+rHkxWxAxq+LD6zJMRM33hG9SLQ2J2R/1OWc1FWRFz+82JeDt1Lah4MqF6FJBrNntx0ekf+vdeQgIZZWUTvGFqte2KLYvVEX415OXHAjIM7DBM4ebdhE8PNj/fT8mh8iECpqpWIgQ06YWS/3MkVsIXUsyyeiBy7hLI1K1pdjNYXN1mIcna7MU6MxHoxBnrQft10RDJkFbYYoPfmPVOF+SZej6IH39eemhKa3kr5gQnXXVFpOugDDkfUejOgHgVrSVOMz6zPPSi9+be2GYY4L/7V9L5G4rP72sELwigbBs8YFDbecHpkPoSeKs0eUeYg0yRfbUzKum2jkxUuVbJY77lCfsOsPD4Ok/Z4I9JwqjX+TW8k837D2p6fbHLF2xsfcIuFw== plexus\victor.alvarezgonzal@PLX10749-002" > /home/vagrant/.ssh/authorized_keys
	 #   chown -R vagrant:vagrant /home/vagrant/.ssh
	 #   chmod 600 /home/vagrant/.ssh/authorized_keys
  SHELL

  end