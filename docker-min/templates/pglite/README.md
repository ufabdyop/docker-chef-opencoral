Minimal Postgresql Docker Image
===

Based on the awesome article here:
http://blog.docker.com/2013/06/create-light-weight-docker-containers-buildroot/

I added a check to the init script that allows you to use a shared volume for 
the DB data directory.  It is currently expecting that to be /tmp/datashare on
the host and /datashare on the container.

Run ./start.sh to build and run the PG container

