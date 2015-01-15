file "/tmp/ssh_wrapper.sh" do
  owner "root"
  mode "0755"
  content "#!/bin/sh\nexec /usr/bin/ssh -i /root/.ssh/id_rsa -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null \"$@\""
end

git "Cloning CoralAPI server..." do
  repository node['opencoral']['apiserver_repository']
  checkout_branch node['opencoral']['apiserver_branch']
  destination node['opencoral']['apiserver_home']
  action :sync
  ssh_wrapper "/tmp/ssh_wrapper.sh"
end

execute "Build coral api server" do
  command "mvn package"
end

# runit_config_dir = node['opencoral']['apiserver_home'] + '/runit'
# link "Creating Symbolic Link for CoralAPI server..." do
#   action :create
#   target_file "/etc/service/"
#   to runit_config_dir
# end
