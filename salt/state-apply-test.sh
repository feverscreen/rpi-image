#!/bin/bash
# This is to help testing salt changes on a Raspberry Pi
# Usage: state-apply-test.sh [devicename] [state.apply params]
# If you need to make changes to top.sls make the changes in `salt/top.sls` This is what is used when testing

device=$1
params=$2

if [[ -z $device ]]; then
  echo "please provide device name. Usage \`state-apply-test.sh [devicename] [state.apply params]\`"
  exit 1
fi

# copy files to local folder
# cp -r basics.sls _modules/ pi/ _states/ timezone.sls salt-migration/ salt/

echo "Delete old salt files on device"
ssh pi@$device "sudo rm -rf salt"
ssh pi@$device "sudo rm -rf /srv/salt"

echo "copying files to device..."
scp -rq ../salt pi@$device:

echo "moving files to /srv..."
ssh pi@$device "sudo cp -r salt /srv/"

cmd="ssh pi@$device \"sudo salt-call --local state.apply $params --state-output=mixed\""
echo "running $cmd"
eval $cmd
