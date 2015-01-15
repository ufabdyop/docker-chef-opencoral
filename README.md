Docker OpenCoral Image
===

Uses a base image with all of coral's prerequisites to build a running instance of coral.  Needs
to be linked to a postgresql image with coral's DB structure and data.

Data Bags
---
This docker image is built using chef-solo and using encrypted data bags.  See the README in the
chef/secret directory for more info.

Starting Container
---
Assuming the postgresql container for coral is running as coraldb:

docker run -d --link coraldb:coraldb --dns 127.0.0.1  -P --name coral docker.nanofab.utah.edu:5000/chef-opencoral

Initially, I tried running coral on a dev box with 512M of memory which turned out to be too little.  I turned it up to 
1024 and that worked.

Building
---
docker build -t docker.nanofab.utah.edu:5000/chef-opencoral .

