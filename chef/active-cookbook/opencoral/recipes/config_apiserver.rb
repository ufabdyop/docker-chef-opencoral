# file "/tmp/ssh_wrapper.sh" do
#   owner "root"
#   mode "0755"
#   content "#!/bin/sh\nexec /usr/bin/ssh -i /root/.ssh/id_rsa -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null \"$@\""
# end
# 

git "Cloning CoralAPI..." do
  repository node['opencoral']['api_repository']
  destination node['opencoral']['api_home']
  revision node['opencoral']['api_revision']
end

git "Cloning CoralAPI server..." do
  repository node['opencoral']['apiserver_repository']
  destination node['opencoral']['apiserver_home']
  revision node['opencoral']['apiserver_revision']
end

execute "Fix permissions" do
  apiserver = node['opencoral']['apiserver_home']
  api = node['opencoral']['api_home']
  command "chown -R coral #{api} #{apiserver}"
end
  
execute "Build coral api" do
  user "coral"
  environment 'HOME' => '/home/coral'
  cwd node['opencoral']['api_home']
  command "/usr/local/maven/bin/mvn -Dmaven.test.skip=true install"
end
 
execute "Build coral apiserver" do
  user "coral"
  environment 'HOME' => '/home/coral'
  cwd node['opencoral']['apiserver_home']
  command "/usr/local/maven/bin/mvn package" #package
end

# 
# runit_config_dir = node['opencoral']['apiserver_home'] + '/runit'
# link "Creating Symbolic Link for CoralAPI server..." do
#   action :create
#   target_file "/etc/service/"
#   to runit_config_dir
# end
