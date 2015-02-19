#!/bin/bash

if [ -z $EXPORTDIR ] 
then
	echo "No export dir. Please set EXPORTDIR env variable (container path)"
	echo "example: EXPORTDIR=/data CORALSERVER=mycoralservername.local /export.sh"
	exit 1
else
	echo "exporting to $EXPORTDIR"
fi

if [ -z $CORALSERVER ] 
then
	echo "No coral server. Please set CORALSERVER env variable"
	exit 1
else
	echo "Coral server: $CORALSERVER"
fi

run &
sleep 5

sudo chown coral $EXPORTDIR
cd /home/coral/opencoral/
perl -i -pe "s/coralserver.local/$CORALSERVER/g" config/site1-prod.properties
ant build | tee $EXPORTDIR/build.log
ant deploy | tee $EXPORTDIR/deploy.log
ant deployAll | tee $EXPORTDIR/deployall.log

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
