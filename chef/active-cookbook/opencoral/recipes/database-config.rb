#
# Cookbook Name:: opencoral
# Recipe:: database-config
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

execute "Configure DB" do
     command "service postgresql start; sleep 5; su postgres -c 'createuser -d -a coraldba'"
end

dbapass = 'fsnhoay59ah'
execute "Configure DB" do
     command "echo \"alter user coraldba with password '#{dbapass}';\" > /tmp/pass.sql"
end

execute "Configure DB" do
     command "su postgres -c 'psql < /tmp/pass.sql'"
end

execute "Configure DB" do
     command "rm /tmp/pass.sql"
end
