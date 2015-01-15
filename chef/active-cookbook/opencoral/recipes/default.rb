#
# Cookbook Name:: opencoral
# Recipe:: default
#
# Copyright 2014, University of Utah Nanofab
#
#

# load passwords
my_secret = Chef::EncryptedDataBagItem.load_secret("/chef/secret/encrypted_data_bag_secret")
passwords = Chef::EncryptedDataBagItem.load("passwords", "general", my_secret)

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

my_secret = Chef::EncryptedDataBagItem.load_secret("/chef/secret/encrypted_data_bag_secret")
passwords = Chef::EncryptedDataBagItem.load("passwords", "general", my_secret)

template "/usr/local/coral/etc/private/.signstore.base64" do
  source "signstore.erb"
  mode "0644"
  variables({
    :coral_signstore => passwords['coral_signstore']
  })
end

file "/usr/local/coral/etc/private/.signstore" do
  owner "coral"
  group "opencoral"
  mode "0644"
  action :touch
end

cookbook_file "/etc/sudoers.d/coral" do
  owner "root"
  group "root"
  mode "0440"
  source "coral-sudoers"
end

execute "base64 decode signstore" do
  command "base64 -d /usr/local/coral/etc/private/.signstore.base64 > /usr/local/coral/etc/private/.signstore"
end
