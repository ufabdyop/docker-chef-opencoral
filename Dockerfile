FROM ufabdyop/chef-opencoral-base:1.1.0

ADD ./chef/base /chef
WORKDIR /chef

### Check that password file exists
ADD container-files/prebuild /usr/local/bin/prebuild
RUN chmod +x /usr/local/bin/prebuild
RUN /usr/local/bin/prebuild

### Opencoral Cookbook Files ###
ADD  chef/active-cookbook/opencoral                          /chef/vendor/cookbooks/opencoral

### Run chef-solo (using librarian for dependencies)
RUN cd /chef; /opt/chef/embedded/bin/librarian-chef install
RUN cd /chef; chef-solo -c solo.rb -j node.json

#CLEANUP
RUN rm -rf /chef/data_bags/passwords/opencoral.json

#ADD EXPORT FEATURE
ADD container-files/export.sh /export.sh

### Merge new recipes ###
# ADD  chef/active-cookbook/to-merge                            /chef/vendor/cookbooks/to-merge
# RUN  rsync -rv /chef/vendor/cookbooks/to-merge/opencoral/ /chef/vendor/cookbooks/opencoral/
# RUN cd /chef; /opt/chef/embedded/bin/librarian-chef install
# RUN cd /chef; chef-solo -c solo.rb -j node.json -o opencoral::start_coralapiserver

# SSH
EXPOSE 22      #SSH
EXPOSE 80      #HTTP (Serves coral.jnlp, IOR for CORBA, and coral jar files)
EXPOSE 8080    #HTTP (Serves coralapiserver endpoint)
EXPOSE 50000   #CORBA PORT
EXPOSE 50001   #CORBA PORT
EXPOSE 50002   #CORBA PORT
EXPOSE 50003   #CORBA PORT
EXPOSE 50004   #CORBA PORT
EXPOSE 50005   #CORBA PORT
EXPOSE 50006   #CORBA PORT
EXPOSE 50007   #CORBA PORT
EXPOSE 50008   #CORBA PORT
EXPOSE 50009   #CORBA PORT
EXPOSE 50010   #CORBA PORT
EXPOSE 50011   #CORBA PORT

#Run This File on Startup
CMD [ "/usr/local/bin/run" ]
