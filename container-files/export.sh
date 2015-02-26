#!/bin/bash

if [ -z $EXPORTDIR ] 
then
	echo "No export dir. Please set EXPORTDIR env variable (container path)"
	echo "example: EXPORTDIR=/data CORALSERVER=mycoralservername.local /export.sh"
	exit 1
else
	echo "exporting to $EXPORTDIR"
fi

run &
sleep 5

sudo chown coral $EXPORTDIR

#Dump DB
sudo su postgres -c "pg_dumpall > $EXPORTDIR/dump.sql"

#Dump files:
sudo mkdir -p $EXPORTDIR/usr/local
sudo chown coral $EXPORTDIR/usr/local
rsync -rvz /usr/local/coral/ $EXPORTDIR/usr/local/coral/
sudo mkdir -p $EXPORTDIR/var/www/html
sudo chown coral $EXPORTDIR/var/www/html
rsync -rvz /var/www/html/coral/ $EXPORTDIR/var/www/html/coral/
sudo chown coral $EXPORTDIR/var/www/html
rsync -rvz /var/www/html/coral/ $EXPORTDIR/var/www/html/coral/
