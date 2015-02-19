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
mkdir $EXPORTDIR/usrlocal
sudo mkdir $EXPORTDIR/usrlocal
sudo chown coral $EXPORTDIR/usrlocal
rsync -rvz /usr/local/coral/ $EXPORTDIR/usrlocal/coral/
sudo mkdir $EXPORTDIR/varwwwhtml
rsync -rvz /var/www/html/coral/ $EXPORTDIR/varwwwhtml/coral/
sudo chown coral $EXPORTDIR/varwwwhtml
rsync -rvz /var/www/html/coral/ $EXPORTDIR/varwwwhtml/coral/
