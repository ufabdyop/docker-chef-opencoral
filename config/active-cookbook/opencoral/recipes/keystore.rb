#
# Cookbook Name:: opencoral
# Recipe:: database-config
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

keypass = data_bag_item('passwords', 'opencoral')['keypass']
storepass = data_bag_item('passwords', 'opencoral')['storepass']
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
