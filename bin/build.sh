#!/bin/bash

CURRENTDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd $CURRENTDIR/..
docker build -t chef-opencoral-vanilla .
