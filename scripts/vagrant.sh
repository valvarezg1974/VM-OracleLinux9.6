#!/bin/bash

sudo date > /tmp/vagrant_box_build_time

sudo mkdir -pm 700 /home/vagrant/.ssh
sudo curl -L https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub -o /home/vagrant/.ssh/authorized_keys
sudo chmod 0600 /home/vagrant/.ssh/authorized_keys
sudo chown -R vagrant:vagrant /home/vagrant/.ssh
