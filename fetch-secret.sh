#!/bin/bash

DOS2UNIX=`which dos2unix`

if [ -z "$DOS2UNIX" ]; then
    echo "dos2unix must be installed"
    echo "run: sudo apt-get install -y dos2unix jq"
    exit 1
fi

JQ=`which jq`

if [ -z "$JQ" ]; then
    echo "jq must be installed"
    exit 1
fi

if [ -z "$CORAL_PASSPHRASE" ]; then
    echo "Need passphrase. To avoid prompt, set \$CORAL_PASSPHRASE environment variable"
    read -s -p "Passphrase to access secret from simple vault: " CORAL_PASSPHRASE
    echo
fi  

if [ -z "$SV_AUTH_STRING" ]; then
    echo "Need username. To avoid prompt, set SV_AUTH_STRING env variable (can include password with SV_AUTH_STRING=user:pass)"
    read -p "CADE (coral) Username: " SV_AUTH_STRING
    echo
fi

curl -k -s 'https://www.nanofab.utah.edu/sv/index.php' \
  -u "$SV_AUTH_STRING" \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  --data "cat=Chef&t1=Docker+Secret&t2=&pf=$CORAL_PASSPHRASE&entrydecrypt=decrypt&decryptraw=true" \
  | jq -r .notes | dos2unix | sh
