#!/bin/bash
service apache2 start
service dnsmasq start
service postgresql start
echo 'nameserver 127.0.0.1' > /etc/resolv.conf
if [ -e /usr/local/coral/sbin/opencoral ]; then 
	/usr/local/coral/sbin/opencoral start
fi

if [ -e /coralapiserver/coralapiserver-0.1.28.jar ]; then 
	java -jar /coralapiserver/coralapiserver-0.1.28.jar server /coralapiserver/coralapi.yml &
fi

/usr/local/bin/copy_public_key.sh &
/usr/sbin/sshd -D
