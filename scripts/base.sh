#!/bin/bash

sudo sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers

sudo yum install -y oracle-database-preinstall-19c

#sudo yum install -y sysstat logwatch sos crash tuned policycoreutils nftables 
#sudo yum install -y  xfsdump cryptsetup nfs-utils mdadm autofs 

#sudo dnf install -y tuned-profiles-oracle
#sudo dnf install -y policycoreutils-python-utils
#sudo dnf install -y targetcli
#sudo dnf install -y iscsi-initiator-utils
#systemctl enable --now target

#sudo yum -y update

#sudo dnf install -y kernel-headers kernel-devel dkms make perl elfutils-libelf-devel
#sudo dnf groupinstall -y "Development Tools"
#sudo yum -y install gcc make gcc-c++ perl grub2-tools net-tools

