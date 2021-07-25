#!/bin/bash
#add fix to exercise2 here
# based on: https://stackoverflow.com/questions/58746915/deleting-a-hosts-file-entry-on-solaris-using-a-script-or-command-directly
sudo sed -i '/127.0.0.1 www.ascii-art.de/d' /etc/hosts
