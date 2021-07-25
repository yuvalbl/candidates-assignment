#!/bin/bash
#add fix to exercise6-fix here

if [ "$(hostname)" = "server1" ]; then
    SOURCE="server1"
    TARGET="server2"
else
    SOURCE="server2"
    TARGET="server1"
fi
echo "Source: ${SOURCE}"
echo "Target: ${TARGET}"

CURRENT_SIZE=0
TOTAL_SIZE=0

# get last arg
declare -a argv=("$@")
declare argc=$((${#argv[@]}-1))
declare target_location=${argv[$argc]}
unset argv[$argc]
echo "Target Location: $target_location" 
array=( "$@" )

# create dir if it doesn't exist'
ssh vagrant@$TARGET "mkdir -p $target_location"

# remove last arg
unset "array[${#array[@]}-1]" 
for i in "${array[@]}"; do
    echo "scp -i ~/.ssh/id_rsa ${i} vagrant@$TARGET:$target_location"
    scp -i ~/.ssh/id_rsa ${i} vagrant@$TARGET:$target_location
    CURRENT_SIZE=$(wc -c < ${i})
    TOTAL_SIZE=$(($TOTAL_SIZE + $CURRENT_SIZE))
done

#print total size of bytes
echo "$TOTAL_SIZE"

# tests:
# bash /vagrant/fixScripts/exercise6-fix.sh ~/.ssh/authorized_keys ~/.ssh/known_hosts /home/vagrant/temp
# bash /vagrant/fixScripts/exercise6-fix.sh /vagrant/Vagrantfile /etc/crontab /home/vagrant/temp2