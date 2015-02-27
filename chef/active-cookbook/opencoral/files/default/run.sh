#!/bin/bash
service apache2 start
service dnsmasq start
service postgresql start
echo 'nameserver 127.0.0.1' > /etc/resolv.conf
if [ -e /usr/local/coral/sbin/opencoral ]; then 
  /usr/local/coral/sbin/opencoral start
fi

/usr/local/bin/copy_public_key.sh &
/usr/sbin/sshd

sudo /usr/sbin/runsvdir-start
