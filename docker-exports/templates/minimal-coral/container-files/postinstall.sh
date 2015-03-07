#!/bin/sh
rsync -rvz /data/usr/local/coral/ /usr/local/coral/
rsync -rvz /data/var/www/html/coral/ /var/www/html/coral/
chown -R coral:coral /usr/local/coral/ /var/www/html/coral/
chmod 755 /usr/local/coral/bin/*
chmod 755 /usr/local/coral/sbin/*

ln -s /usr/local/coral/share/IOR /var/www/html/IOR

