FROM chef-opencoral-base:1.1.0

ADD ./chef/base /chef
WORKDIR /chef

### Check that password file exists
ADD container-files/prebuild /usr/local/bin/prebuild
RUN chmod +x /usr/local/bin/prebuild
RUN /usr/local/bin/prebuild

### Opencoral Cookbook Files ###
ADD  chef/active-cookbook/opencoral                     	     /chef/vendor/cookbooks/opencoral

### Run chef-solo (using librarian for dependencies)
RUN cd /chef; /opt/chef/embedded/bin/librarian-chef install
RUN cd /chef; chef-solo -c solo.rb -j node.json

#CLEANUP
RUN rm -rf /chef/data_bags/passwords/opencoral.json

#ADD EXPORT FEATURE
ADD container-files/export.sh /export.sh

# SSH
EXPOSE 22

#Run This File on Startup
CMD [ "/usr/local/bin/run" ]
