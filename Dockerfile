FROM ufabdyop/chef-opencoral-base:1.1.3

ADD ./config/chef /chef
WORKDIR /chef

### Check that password file exists
ADD container-files/prebuild /usr/local/bin/prebuild
RUN chmod +x /usr/local/bin/prebuild
RUN /usr/local/bin/prebuild

### Run chef-solo (using librarian for dependencies)
RUN cd /chef; /opt/chef/embedded/bin/librarian-chef install
RUN cd /chef; chef-solo -c solo.rb -j node.json

#CLEANUP
RUN rm -rf /chef/data_bags/passwords/opencoral.json

#ADD EXPORT FEATURE
ADD container-files/export.sh /export.sh

#EXPOSED PORTS ARE:
#22:   SSH 
#80:   HTTP (Serves coral.jnlp, IOR for CORBA, and coral jar files)
#8080: HTTP (Serves coralapiserver endpoint)
#50000 to 50011 CORBA PORTS
EXPOSE 22 80 8080 50000 50001 50002 50003 50004 50005 50006 50007 50008 50009 50010 50011

#Run This File on Startup
CMD [ "/usr/local/bin/run" ]
