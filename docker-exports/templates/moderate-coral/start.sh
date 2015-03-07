#!/bin/bash
CURRENTDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd $CURRENTDIR
LOGDIR=$CURRENTDIR/log
DOCKERHOSTIP=$(ip addr show docker0 | perl -ne '/inet (.*)\// && print $1')

docker build -t moderate-coral .
docker rm -f moderate-coral-container 2> /dev/null || true
CMD="docker run --name moderate-coral-container -d \
	-v $LOGDIR:/var/log/coral \
	--add-host coraldb:$DOCKERHOSTIP \
	-e CORALSERVER=coralserver.local \
	-p 50000:50000 \
	-p 50001:50001 \
	-p 50002:50002 \
	-p 50003:50003 \
	-p 50004:50004 \
	-p 50005:50005 \
	-p 50006:50006 \
	-p 50007:50007 \
	-p 50008:50008 \
	-p 50009:50009 \
	-p 50010:50010 \
	-p 50011:50011 \
	-p 80:80 \
	moderate-coral"
echo "Running $CMD"
$CMD
