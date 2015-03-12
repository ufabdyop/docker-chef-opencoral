cookbook_file "/home/coral/opencoral/src/xml/equipment/Area.site1.xml" do
  mode "0644"
  user "coral"
  source "equipment.xml"
end

execute "start psql" do
  command "service postgresql start"
end

execute "wait for psql on coraldb" do
  command "sleep 4"
end

cookbook_file "/tmp/equipment.sql" do
  mode "0644"
  user "coral"
  source "equipment.sql"
end

execute "Bootstrap equipment tree" do
     command "su postgres -c 'psql coral < /tmp/equipment.sql'"
end

execute "Cleanup" do
     command "rm /tmp/equipment.sql"
end

