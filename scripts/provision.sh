#!/usr/bin/env bash

# Change the Default Keyboard Layout
#sudo sed -i 's/"fr"/"es"/g' /etc/default/keyboard

# Install OS updates
#sudo yum update
#sudo yum upgrade -y

# Disable Unix Firewall
sudo systemctl disable firewalld
#sudo echo "Servidor Web creado con PACKER" > /var/www/html/index.html
#sudo usermod -G vboxsf vagrant

# Install Desktop Tools
sudo yum install -y open-vm-tools-desktop  curl wget git vim nano bash-completion
#build-essential dkms linux-headers-$(uname -r)

#sudo poweroff