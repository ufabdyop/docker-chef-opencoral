#
# Cookbook Name:: opencoral
# Recipe:: database-config
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

template "/home/coral/opencoral/config/site1-prod.properties" do
  source "coral-config.properties.erb"
  mode "0644"
  variables({
  })
end

