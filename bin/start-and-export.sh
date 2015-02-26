#!/bin/bash

RANDOMSUFFIX=`head /dev/urandom | md5sum | perl -pe 's/(........).*/$1/'`
EXPORTDIR=/tmp/coral-export-$RANDOMSUFFIX
mkdir -p $EXPORTDIR

docker rm -f coral-vanilla 2> /dev/null 
docker run --rm -a stdout --name coral-vanilla \
                -p 2233:22 \
                -p 80:80 \
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
                -v $EXPORTDIR:/export  \
		-e EXPORTDIR=/export \
		ufabdyop/chef-opencoral-vanilla \
		/export.sh
		
echo Exported to $EXPORTDIR
