#!/bin/bash
#add fix to exercise4-server1 here

# add server2 as host
sudo sed -i '$ a 192.168.100.11 server2' /etc/hosts

# allow password auhentication (so server2 can connect to server1)
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sudo sed -i 's/#PermitEmptyPasswords no/PermitEmptyPasswords yes/g' /etc/ssh/sshd_config
sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config

# restart ssh service
sudo service ssh reload

