#!/bin/sh
cd /var/www/html
java NanoHTTPD &
sleep 4

echo 127.0.0.1 $CORALSERVER >> /etc/hosts
/usr/local/coral/sbin/server_start Admin

#just hang out, waiting for interrupt
while true; do echo `date` >> /var/log/coral/sleep.log; sleep 30; done
