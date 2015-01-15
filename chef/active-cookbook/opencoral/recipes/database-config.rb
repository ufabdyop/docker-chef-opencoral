#
# Cookbook Name:: opencoral
# Recipe:: database-config
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
dbapass = 'fsnhoay59ah'
readerpass = 'haflksdtiuy'

execute "Configure DB" do
     command "service postgresql start; sleep 5; su postgres -c 'createuser -d -a coraldba'"
end

execute "Configure DB" do
     command "su postgres -c 'createdb -e -O coraldba coral \"OpenCoral Database\"'"
end

execute "Configure DB" do
     command "echo \"alter user coraldba with password '#{dbapass}';\" > /tmp/pass.sql"
end

execute "Configure DB" do
     command "su postgres -c 'psql < /tmp/pass.sql'"
end

execute "Configure DB" do
     command "rm /tmp/pass.sql"
end

template "/home/coral/opencoral/src/sql/Postgres/initialSetup/lab_db.sql" do
  source "lab_db.sql.erb"
  mode "0644"
  variables({
    :dbapassword => dbapass,
    :readerpassword => readerpass
  })
end

bash "Configure DB Passwords" do
  user "coral"
  code <<-EOF
  for i in accmgr actmgr admmgr eqmgr hwrmgr polmgr resmgr rptmgr rscmgr runmgr stfmgr svcmgr coraldba; do echo '*:*:*:'$i':#{dbapass}' >> /home/coral/.pgpass; done
  chmod 0600 /home/coral/.pgpass
  chown coral /home/coral/.pgpass
  EOF
end

execute "Remove interactive pass prompt from makefile" do 
  user "coral"
  cwd "/home/coral/opencoral/src/sql/Postgres/initialSetup"
  command "perl -i -pe 's/WU/U/' Makefile"
end

bash "initialize DB" do
  user "coral"
  cwd "/home/coral/opencoral/src/sql/Postgres/initialSetup"
  code "cd /home/coral/opencoral/src/sql/Postgres/initialSetup; make > /tmp/initialSetup.log"
end

#cleanup
file ("/home/coral/.pgpass") { action :delete }
file ("/home/coral/opencoral/src/sql/Postgres/initialSetup/lab_db.sql") { action :delete }
