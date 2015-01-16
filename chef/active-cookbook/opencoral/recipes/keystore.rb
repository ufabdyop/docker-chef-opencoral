#
# Cookbook Name:: opencoral
# Recipe:: database-config
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
my_secret = Chef::EncryptedDataBagItem.load_secret("/chef/secret/encrypted_data_bag_secret")
passwords = Chef::EncryptedDataBagItem.load("passwords", "general", my_secret)

keypass = passwords['coral_keypass']
storepass = passwords['coral_storepass']

orgdname = 'CN=OpenCoral, OU=your_organization, O=your_institution, L=your_city, ST=your_state, C=US'

file "/usr/local/coral/etc/private/.signstore" do
  action :delete
end

execute "Create Keystore" do
     command "keytool -genkey -alias coralkey -keyalg rsa -keystore /usr/local/coral/etc/private/.signstore -storepass '#{storepass}' -dname '#{orgdname}' -keypass '#{keypass}'"
     user "coral"
end

file "/home/coral/opencoral/config/.jspw.properties" do
  content "jarsign.storepass=#{storepass}
jarsign.keypass=#{keypass}"
  user "coral"
end
