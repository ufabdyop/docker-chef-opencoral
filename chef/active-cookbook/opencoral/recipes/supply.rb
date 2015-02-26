cookbook_file "/home/coral/opencoral/src/xml/supply/Area.site1.xml" do
  mode "0644"
  user "coral"
  source "supply.xml"
end

cookbook_file "/tmp/supply.sql" do
  mode "0644"
  user "coral"
  source "supply.sql"
end

execute "start psql" do
  command "service postgresql start"
end

execute "wait for psql on coraldb" do
  command "sleep 4"
end

execute "Bootstrap supply tree" do
     command "su postgres -c 'psql coral < /tmp/supply.sql'"
end

execute "Cleanup" do
     command "rm /tmp/supply.sql"
end

