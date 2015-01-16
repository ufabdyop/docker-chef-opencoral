execute "add alias for coraldb" do
  command "echo '127.0.0.1 coraldb' >> /etc/hosts"
end

execute "start psql" do
  command "service postgresql start"
end

execute "ping coraldb" do
  command "sleep 4"
end

execute "BUGFIX" do
  command "perl -i -pe 's/(WHERE master = .Bootstrap project. AND )project( = .Bootstrap account.)/$1slave$2/' /home/coral/opencoral/build.xml"
end

bash "Create bootstrap user" do
  user "coral"
  cwd "/home/coral/opencoral"
  code "/usr/local/ant-1.8.2/bin/ant bootstrapUser"
end
