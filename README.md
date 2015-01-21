Docker OpenCoral Image
===

Uses a base image with all of coral's prerequisites to build a running instance of coral.  It can be linked to a postgresql image with coral's DB structure and data.

Data Bags
---
This docker image is built using chef-solo and using encrypted data bags.  See the README in the
chef/secret directory for more info.

Starting Container
---
Assuming the postgresql container for coral is running as coraldb:

    docker run -d --link coraldb:coraldb --dns 127.0.0.1  -P --name coral chef-opencoral-vanilla

You may set up key pair authentication like so:

First generate a key:

    mkdir -p /tmp/coral-container-keys
    ssh-keygen -f /tmp/coral-container-keys/id_rsa -N 'my passphrase'

Then start container and use volume sharing to allow authentication using that key (port forwarding 2233 to 22)

    docker run --name coral -d -p 2233:22 -v /tmp/coral-container-keys:/coral_public_key chef-opencoral-vanilla

Then ssh into container

    ssh -Y -i /tmp/coral-container-keys/id_rsa -p 2233 -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no coral@localhost

Building
---
docker build -t chef-opencoral-vanilla .

Initially, I tried running coral on a dev box with 512M of memory which turned out to be too little.  I turned it up to 
1024 and that worked.

