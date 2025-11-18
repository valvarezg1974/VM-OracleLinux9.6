VBOX_VERSION=$(cat /home/vagrant/.vbox_version)

sudo dnf install epel-release -y
sudo dnf install dkms kernel-uek-devel gcc make bzip2 perl elfutils-libelf-devel
sudo yum -y install wget
#wget http://download.virtualbox.org/virtualbox/6.1.38/VBoxGuestAdditions_6.1.38.iso -P /tmp
sudo wget http://download.virtualbox.org/virtualbox/7.1.6/VBoxGuestAdditions_7.1.6.iso -P /tmp
#sudo mount /tmp/VBoxGuestAdditions_7.1.6.iso /mnt

sudo /mnt/VBoxLinuxAdditions.run

sudo systemctl reboot -i

#sudo sh VBoxLinuxAdditions.run

cd /tmp
#sudo mount -o loop /home/vagrant/VBoxGuestAdditions_$VBOX_VERSION.iso /mnt
#sudo sh /mnt/VBoxLinuxAdditions.run
sudo umount /mnt
sudo rm -rf /tmp/VBoxGuestAdditions_*.iso



