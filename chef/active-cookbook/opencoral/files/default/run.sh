#!/bin/bash
service apache2 start
service dnsmasq start
service postgresql start
echo 'nameserver 127.0.0.1' > /etc/resolv.conf
/usr/local/coral/sbin/opencoral start
/usr/local/bin/copy_public_key.sh &
/usr/sbin/sshd -D
