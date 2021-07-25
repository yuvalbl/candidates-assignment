#!/bin/bash
#add fix to exercise5-server1 here
LOCAL_HOME_DIR=/home/vagrant
LOCAL_SSH_KEY=$LOCAL_HOME_DIR/.ssh/id_rsa
SHARED_SSH_DIR=/vagrant/.ssh
SHARED_SSH_KEY=$SHARED_SSH_DIR/id_rsa

# If shared ssh not created
if [ ! -f "$SHARED_SSH_KEY" ]; then
    echo "shared ssh NOT key exists - creating..."
    ssh-keygen -f $LOCAL_SSH_KEY -P ''
    mkdir $SHARED_SSH_DIR
    # copy local keys to shared directort
    cp $LOCAL_SSH_KEY $SHARED_SSH_DIR
    cp $LOCAL_SSH_KEY.pub $SHARED_SSH_DIR
fi

# If local ssh not exist
if [ ! -f "$LOCAL_SSH_KEY" ]; then
    # copy from shared directort
    cp -r $SHARED_SSH_DIR $LOCAL_HOME_DIR
fi

# add to authorized keys (do as user vagrant)
sudo su -c "cat $LOCAL_SSH_KEY.pub >> $LOCAL_HOME_DIR/.ssh/authorized_keys" vagrant

# permissions
sudo chown -R vagrant /home/vagrant/.ssh
sudo chmod -R 700 /home/vagrant/.ssh
sudo chmod 600 /home/vagrant/.ssh/authorized_keys

# disable host checking
sudo sed -i 's/#   StrictHostKeyChecking ask/StrictHostKeyChecking no/g' /etc/ssh/ssh_config