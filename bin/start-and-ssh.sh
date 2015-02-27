#!/bin/bash

RANDOMSUFFIX=`head /dev/urandom | md5sum | perl -pe 's/(........).*/$1/'`
KEYDIR=/tmp/coral-container-keys-$RANDOMSUFFIX
mkdir -p $KEYDIR
ssh-keygen -f $KEYDIR/id_rsa -N ''

docker rm -f coral-vanilla 2> /dev/null 
docker run -d --name coral-vanilla \
                -p 2233:22 \
                -p 80:80 \
                -p 8080:8080 \
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
                -v $KEYDIR:/coral_public_key  \
                ufabdyop/chef-opencoral-vanilla

echo 'Run this command after services finish starting (give it about 5 seconds or so):'
echo ssh -Y -i $KEYDIR/id_rsa -p 2233 -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no coral@localhost
