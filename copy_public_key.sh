#!/bin/bash

function check_for_key {
	if [ -e /coral_public_key ]; then 
		mkdir -p /home/coral/.ssh
		cp /coral_public_key/authorized_keys /home/coral/.ssh/authorized_keys
		chown -R coral /home/coral/.ssh/
		chmod -R 700 /home/coral/.ssh/
		exit
	fi
}

while true
do
	check_for_key
	sleep 5
done
