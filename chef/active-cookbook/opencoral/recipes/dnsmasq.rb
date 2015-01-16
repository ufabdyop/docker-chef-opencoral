cookbook_file "01hosts" do
  path "/etc/dnsmasq.d/01hosts"
end

execute "start dnsmasq" do
  command "service dnsmasq start"
end
