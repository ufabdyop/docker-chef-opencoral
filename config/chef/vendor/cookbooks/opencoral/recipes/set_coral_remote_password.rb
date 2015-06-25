execute "Update Coral API" do
  user "coral"
  environment 'HOME' => '/home/coral'
  cwd node['opencoral']['api_home']
  command "git pull origin master"
end

bash "Run Start Script to Start OpenCoral" do
  user "coral"
  cwd "/home/coral"
  code "
	rm /usr/local/coral/etc/pid/*pid
	sudo /usr/local/bin/run 2>&1 | tee /tmp/run0.log &
	sleep 10
	"
end

coralpass = data_bag_item('passwords', 'opencoral')['coral_user_password']
if (coralpass) then
	execute "Set coral password" do
	  user "coral"
	  environment 'HOME' => '/home/coral'
	  cwd node['opencoral']['api_home']
	  command "/usr/local/maven/bin/mvn exec:java -Dexec.mainClass=edu.utah.nanofab.coralapi.examples.PasswordChange -Dexec.args=\"coral #{coralpass}\""
	end
end
