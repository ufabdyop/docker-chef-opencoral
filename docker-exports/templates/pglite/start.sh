#!/bin/bash
CURRENTDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
LOCALDATADIR=$CURRENTDIR/data
IMPORTSQL=$CURRENTDIR/files/dump.sql
CASTSQL=$CURRENTDIR/files/Pg83-implicit-casts.sql_id22
DBPORT="5432"
DOCKERHOSTIP=$(ip addr show docker0 | perl -ne '/inet (.*)\// && print $1')
cd $CURRENTDIR/docker

function main {
	buildDocker
	startDocker
	initDbIfFirstRun
}

function buildDocker {
	docker build -t pglite .
}

function startDocker {
	docker rm -f coraldb 2> /dev/null || true
        docker run -d -v $LOCALDATADIR:/datashare -p $DOCKERHOSTIP:$DBPORT:5432 --name coraldb pglite
}

function stopDocker {
	docker stop coraldb
}

function initDbIfFirstRun {
	if [ ! -e $LOCALDATADIR/dbInitFlag ]; then
		touch $LOCALDATADIR/dbInitFlag
		sleep 5 #give database time to start
		populateDatabase
		stopDocker
		removeTrustedAuth
		startDocker
	fi
}

function populateDatabase {
	echo "Running dump file and implicit casting file for first run"
	psql -U postgres -p $(docker port coraldb 5432 | cut -f 2 -d:) -h $DOCKERHOSTIP -f $IMPORTSQL
	psql -U postgres -p $(docker port coraldb 5432 | cut -f 2 -d:) -h $DOCKERHOSTIP coral -f $CASTSQL
}

function removeTrustedAuth {
	echo "Removing trusted auth"
	rm $LOCALDATADIR/pg_hba.conf
	echo host all all 0.0.0.0 0.0.0.0 md5 > $LOCALDATADIR/pg_hba.conf
}

main
