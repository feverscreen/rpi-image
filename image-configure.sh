#!/bin/bash

# This script is to configure the SD card on the Raspberry Pi

set -ex

host=raspberrypi.local
userHost=pi@$host

echo "Installing saltstack"
scp install-saltstack.sh $userHost:
ssh $userHost "sudo ./install-saltstack.sh"
ssh $userHost "sudo rm ./install-saltstack.sh"

echo "Applying salt state"
cd salt 
./state-apply-test.sh $host
cd ..
ssh $userHost "sudo rm -rf /srv/*"

ssh $userHost "sudo rm /etc/salt/minion_id"

ssh $userHost "sudo apt-get update "
ssh $userHost "sudo apt-get upgrade -y"
ssh $userHost "sudo apt-get autoremove -y"
