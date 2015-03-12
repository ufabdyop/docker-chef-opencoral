FROM ufabdyop/chef-opencoral-base:1.1.0

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

#SSH
EXPOSE 22

#HTTP (Serves coral.jnlp, IOR for CORBA, and coral jar files)
EXPOSE 80

#HTTP (Serves coralapiserver endpoint)
EXPOSE 8080

#CORBA PORTS
EXPOSE 50000
EXPOSE 50001
EXPOSE 50002
EXPOSE 50003
EXPOSE 50004
EXPOSE 50005
EXPOSE 50006
EXPOSE 50007
EXPOSE 50008
EXPOSE 50009
EXPOSE 50010
EXPOSE 50011

#Run This File on Startup
CMD [ "/usr/local/bin/run" ]
