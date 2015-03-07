#!/bin/bash

CURRENTDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd $CURRENTDIR
TIMESTAMP=`date +%Y-%m-%d-%H-%M-%S`
RANDOMSUFFIX=`head /dev/urandom | md5sum | perl -pe 's/(........).*/$1/'`
EXPORTBASE=$CURRENTDIR/../docker-exports/out-$TIMESTAMP-$RANDOMSUFFIX
EXPORTDIR=$EXPORTBASE/files
mkdir -p $EXPORTDIR

docker rm -f chef-opencoral-vanilla-container 2> /dev/null 
docker run --rm -a stdout --name chef-opencoral-vanilla-container \
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

rsync -rvz $CURRENTDIR/../docker-exports/templates/ $EXPORTBASE/
mkdir -p $EXPORTBASE/minimal-coral/data
sudo chmod -R 777 $EXPORTDIR
mv $EXPORTDIR/usr $EXPORTBASE/minimal-coral/data
mv $EXPORTDIR/var $EXPORTBASE/minimal-coral/data
cp -r $EXPORTBASE/minimal-coral/data $EXPORTBASE/moderate-coral/
mv $EXPORTDIR/home/coral/opencoral $EXPORTBASE/moderate-coral/data
mv $EXPORTBASE/files/dump.sql $EXPORTBASE/pglite/files
sudo chmod -R 755 $EXPORTBASE
mv $EXPORTBASE /tmp
echo Exported to /tmp/out-$TIMESTAMP-$RANDOMSUFFIX
