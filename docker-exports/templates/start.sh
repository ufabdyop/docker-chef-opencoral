#!/bin/bash

CURRENTDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd $CURRENTDIR
cd pglite
./start.sh
cd ../minimal-coral
./start.sh

