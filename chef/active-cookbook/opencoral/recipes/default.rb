#
# Cookbook Name:: opencoral
# Recipe:: default
#
# Copyright 2014, University of Utah Nanofab
#
#

#load passwords
my_secret = Chef::EncryptedDataBagItem.load_secret("/chef/secret/encrypted_data_bag_secret")
passwords = Chef::EncryptedDataBagItem.load("passwords", "general", my_secret)

#set root password
rootpass = passwords['root']
execute "Set root password" do
  command "echo 'root:#{rootpass}' | chpasswd"
end

execute "create coral user" do
  command "useradd -m coral -s /bin/bash"
end

group "opencoral" do
  members ['coral']
end

directory "/var/www/html/coral" do
  owner "coral"
  group "opencoral"
  mode 00775
  action :create
end

directory "/usr/local/coral/etc/private" do
  recursive true
end

directory "/usr/local/coral/share/certs" do
  recursive true
end

execute "set directory permissions for coral" do
  command "chown -R coral:opencoral /usr/local/coral && chmod -R 755 /usr/local/coral"
end

cookbook_file "/etc/sudoers.d/coral" do
  owner "root"
  group "root"
  mode "0440"
  source "coral-sudoers"
end
