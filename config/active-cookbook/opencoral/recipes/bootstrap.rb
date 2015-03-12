execute "add alias for coraldb" do
  command "echo '127.0.0.1 coraldb' >> /etc/hosts"
end

execute "start psql" do
  command "service postgresql start"
end

execute "wait for psql on coraldb" do
  command "sleep 4"
end

execute "BUGFIX" do
  command "perl -i -pe 's/(WHERE master = .Bootstrap project. AND )project( = .Bootstrap account.)/$1slave$2/' /home/coral/opencoral/build.xml"
end

cookbook_file "/tmp/build.xml.patch" do
  source "build.xml.patch"
end

execute "Second BUGFIX" do
  cwd "/home/coral/opencoral"
  command "patch -N -p0 < /tmp/build.xml.patch || true"
end

bash "Create bootstrap user" do
  user "coral"
  cwd "/home/coral/opencoral"
  code "/usr/bin/ant bootstrapUser"
end
