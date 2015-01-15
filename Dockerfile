FROM docker.nanofab.utah.edu:5000/chef-opencoral-base:1.0.1

ADD ./chef/base /chef
WORKDIR /chef

### Check that secret file exists
ADD prebuild /usr/local/bin/prebuild
RUN chmod +x /usr/local/bin/prebuild
RUN /usr/local/bin/prebuild

### Opencoral Cookbook Files ###
ADD  chef/active-cookbook/opencoral/CHANGELOG.md                     /chef/vendor/cookbooks/opencoral/CHANGELOG.md
ADD  chef/active-cookbook/opencoral/templates/default/signstore.erb  /chef/vendor/cookbooks/opencoral/templates/default/signstore.erb
ADD  chef/active-cookbook/opencoral/metadata.rb                      /chef/vendor/cookbooks/opencoral/metadata.rb
ADD  chef/active-cookbook/opencoral/README.md                        /chef/vendor/cookbooks/opencoral/README.md
ADD  chef/active-cookbook/opencoral/files/default/id_rsa.pub         /chef/vendor/cookbooks/opencoral/files/default/id_rsa.pub
ADD  chef/active-cookbook/opencoral/files/default/gitlab.crt         /chef/vendor/cookbooks/opencoral/files/default/gitlab.crt
ADD  chef/active-cookbook/opencoral/files/default/coral-sudoers      /chef/vendor/cookbooks/opencoral/files/default/coral-sudoers

### Default Stuff with Coral User
ADD  chef/active-cookbook/opencoral/recipes/default.rb               /chef/vendor/cookbooks/opencoral/recipes/default.rb
RUN cd /chef; /opt/chef/embedded/bin/librarian-chef install
RUN cd /chef; chef-solo -c solo.rb -j node.json -o 'opencoral::default'

### Get Source
ADD chef/active-cookbook/opencoral/recipes/source.rb                 /chef/vendor/cookbooks/opencoral/recipes/source.rb
RUN cd /chef; /opt/chef/embedded/bin/librarian-chef install
RUN cd /chef; chef-solo -c solo.rb -j node.json -o 'opencoral::source'

### Install DB
ADD chef/active-cookbook/opencoral/files/default                                   /chef/vendor/cookbooks/opencoral/files/default
ADD chef/active-cookbook/opencoral/files/default/pg_hba.conf                       /chef/vendor/cookbooks/opencoral/files/default/pg_hba.conf
ADD chef/active-cookbook/opencoral/files/default/Pg83-implicit-casts.sql_id22      /chef/vendor/cookbooks/opencoral/files/default/Pg83-implicit-casts.sql_id22
ADD chef/active-cookbook/opencoral/files/default/postgresql.key                    /chef/vendor/cookbooks/opencoral/files/default/postgresql.key
ADD chef/active-cookbook/opencoral/files/default/postgresql.pem                    /chef/vendor/cookbooks/opencoral/files/default/postgresql.pem
ADD chef/base/vendor/cookbooks/postgresql                                         /chef/vendor/cookbooks/postgresql
ADD chef/active-cookbook/opencoral/recipes/database.rb                 /chef/vendor/cookbooks/opencoral/recipes/database.rb
RUN cd /chef; /opt/chef/embedded/bin/librarian-chef install
RUN cd /chef; chef-solo -c solo.rb -j node.json -o 'opencoral::database'

### Configure DB
ADD chef/active-cookbook/opencoral/recipes/database-config.rb                 /chef/vendor/cookbooks/opencoral/recipes/database-config.rb
RUN cd /chef; /opt/chef/embedded/bin/librarian-chef install
RUN cd /chef; chef-solo -c solo.rb -j node.json -o 'opencoral::database-config'

### Build Source
# ADD chef/active-cookbook/opencoral/recipes/build_source.rb                 /chef/vendor/cookbooks/opencoral/recipes/build_source.rb
# RUN cd /chef; /opt/chef/embedded/bin/librarian-chef install
# RUN cd /chef; chef-solo -c solo.rb -j node.json -o 'opencoral::build_source'
# 
# ### Deploy Source
# ADD chef/active-cookbook/opencoral/recipes/deploy_source.rb                 /chef/vendor/cookbooks/opencoral/recipes/deploy_source.rb
# RUN cd /chef; /opt/chef/embedded/bin/librarian-chef install
# RUN cd /chef; chef-solo -c solo.rb -j node.json -o 'opencoral::deploy_source'
# 
# ### Configure SSH
# ADD  chef/active-cookbook/opencoral/recipes/ssh.rb                   /chef/vendor/cookbooks/opencoral/recipes/ssh.rb
# RUN cd /chef; /opt/chef/embedded/bin/librarian-chef install
# RUN cd /chef; chef-solo -c solo.rb -j node.json -o 'opencoral::ssh'
# 
# ### Configure DNSMASQ
# ADD  chef/active-cookbook/opencoral/recipes/dnsmasq.rb                   /chef/vendor/cookbooks/opencoral/recipes/dnsmasq.rb
# ADD  chef/active-cookbook/opencoral/files/default/01hosts                   /chef/vendor/cookbooks/opencoral/files/default/01hosts
# RUN cd /chef; /opt/chef/embedded/bin/librarian-chef install
# RUN cd /chef; chef-solo -c solo.rb -j node.json -o 'opencoral::dnsmasq'
# 
# ### Install psql
# ADD  chef/active-cookbook/opencoral/recipes/add_sql_client.rb		/chef/vendor/cookbooks/opencoral/recipes/add_sql_client.rb
# RUN cd /chef; /opt/chef/embedded/bin/librarian-chef install
# RUN cd /chef; chef-solo -c solo.rb -j node.json -o 'opencoral::add_sql_client'
# 
# ### Setup CoralAPI server
# #ADD chef/active-cookbook/opencoral/recipes/config_apiserver.rb		/chef/vendor/cookbooks/opencoral/recipes/config_apiserver.rb
# #ADD chef/active-cookbook/opencoral/attributes/default.rb		/chef/vendor/cookbooks/opencoral/attributes/default.rb
# #RUN cd /chef; /opt/chef/embedded/bin/librarian-chef install
# #RUN cd /chef; chef-solo -c solo.rb -j node.json -o 'opencoral::config_apiserver'
# 
# ### private key and source for checking out automated billing
# ADD  chef/active-cookbook/opencoral/recipes/automated_billing.rb		/chef/vendor/cookbooks/opencoral/recipes/automated_billing.rb
# COPY  chef/active-cookbook/opencoral/files/default/nose-1.3.4-tarball 		/chef/vendor/cookbooks/opencoral/files/default/nose-1.3.4-tarball
# ADD  chef/base/data_bags/passwords/files.json                                        /chef/data_bags/passwords/files.json
# RUN cd /chef; /opt/chef/embedded/bin/librarian-chef install
# RUN cd /chef; chef-solo -c solo.rb -j node.json -o 'opencoral::automated_billing'
# 
# ### Install psql
# ADD  chef/active-cookbook/opencoral/recipes/set_locale.rb		/chef/vendor/cookbooks/opencoral/recipes/set_locale.rb
# RUN cd /chef; /opt/chef/embedded/bin/librarian-chef install
# RUN cd /chef; chef-solo -c solo.rb -j node.json -o 'opencoral::set_locale'

# SSH
EXPOSE 22

#Run This File on Startup
ADD run /usr/local/bin/run
RUN chmod +x /usr/local/bin/run
CMD [ "/usr/local/bin/run" ]
