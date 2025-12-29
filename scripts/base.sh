#!/bin/bash

sudo sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers
#sudo yum -y install net-tools 

sudo dnf install -y oracle-database-preinstall-19c
sudo yum -y update

#sudo dnf install -y kernel-headers kernel-devel dkms make perl elfutils-libelf-devel
#sudo dnf groupinstall -y "Development Tools"
#sudo yum -y install gcc make gcc-c++ perl grub2-tools net-tools

#sudo yum kernel-devel-`uname -r`
#sudo dnf install -y epel-release
#sudo dnf makecache
#yum -y install epel-release.noarch
#rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm
#sudo yum -y install httpd* php mariadb*
#sudo dnf config-manager --enable crb
