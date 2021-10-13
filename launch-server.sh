#!/bin/bash

cd $HOME

# Form Consul Cluster
ps -C consul
retval=$?
if [ $retval -eq 0 ]; then
  sudo killall consul
fi
touch $HOME/consul.log
sudo chmod 660 $HOME/consul.log
sudo cp /vagrant/consul-config/consul-server-east.hcl /etc/consul.d/consul-server-east.hcl
sudo nohup consul agent --config-file /etc/consul.d/consul-server-east.hcl &>$HOME/consul.log &

# Form Nomad Cluster
ps -C nomad
retval=$?
if [ $retval -eq 0 ]; then
  sudo killall nomad
fi
touch $HOME/nomad.log
sudo chmod 660 $HOME/nomad.log
sudo cp /vagrant/nomad-config/nomad-server-east.hcl /etc/nomad.d/nomad-server-east.hcl
sudo nohup nomad agent -config /etc/nomad.d/nomad-server-east.hcl &>$HOME/nomad.log &
