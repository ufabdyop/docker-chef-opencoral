#
# Cookbook Name:: opencoral
# Recipe:: default
#
# Copyright 2014, University of Utah Nanofab
#
# All rights reserved - Do Not Redistribute
#

# load passwords
my_secret = Chef::EncryptedDataBagItem.load_secret("/chef/secret/encrypted_data_bag_secret")
passwords = Chef::EncryptedDataBagItem.load("passwords", "files", my_secret)

cookbook_file "/tmp/nose-1.3.4.tar.gz" do
  source "nose-1.3.4-tarball"
  mode "0644"
end

file "/root/.ssh/id_rsa" do
  mode "0600"
  owner "root"
  content passwords['ddsbox_id_rsa']
end

file "/root/.pgpass" do
  mode "0600"
  owner "root"
  content "*:*:*:coraldba:coraldba\n"
end

file "/tmp/git_wrapper.sh" do
  owner "root"
  mode "0755"
  content "#!/bin/sh\nexec /usr/bin/ssh -i /root/.ssh/id_rsa -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null \"$@\""
end

git "/home/coral/automated-billing" do
  repository "git@gitlab.eng.utah.edu:ryant/automated-billing.git"
  checkout_branch "develop"
  # revision "develop"
  action :sync
  ssh_wrapper "/tmp/git_wrapper.sh" #the path to our private key file
end

execute "set up automated billing" do
  command "cp /home/coral/automated-billing/python/costrecovery/settings/settings.py.template /home/coral/automated-billing/python/costrecovery/settings/settings.py"
end

package "python-setuptools"

execute "install nose" do
  command "cd /tmp; tar xvzf nose-1.3.4.tar.gz; cd nose-1.3.4; python setup.py install; cd /tmp; rm -rf nose-1.3.4 nose-1.3.4.tar.gz"
end
