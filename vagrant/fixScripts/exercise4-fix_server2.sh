#!/bin/bash
#add fix to exercise4-server2 here

# add server1 as host
sudo sed -i '$ a 192.168.100.10 server1' /etc/hosts

# add server1 to known_hosts
# ssh-keyscan server1 >> ~/.ssh/known_hosts

# allow password auhentication (so server1 can connect to server2)
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sudo sed -i 's/#PermitEmptyPasswords no/PermitEmptyPasswords yes/g' /etc/ssh/sshd_config
sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config

# restart ssh service
sudo service ssh reload

