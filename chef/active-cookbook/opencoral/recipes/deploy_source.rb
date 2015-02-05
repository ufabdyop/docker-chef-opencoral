execute "add alias for coraldb" do
  command "echo '127.0.0.1 coraldb' >> /etc/hosts"
end

cookbook_file "/usr/local/bin/run" do
  mode "0755"
  user "root"
  source "run.sh"
end

cookbook_file "/usr/local/bin/copy_public_key.sh" do
  mode "0755"
  user "root"
  source "copy_public_key.sh"
end

bash "Run Start Script to Start Apache/Postgresql" do
  user "coral"
  cwd "/home/coral"
  code "sudo /usr/local/bin/run 2>&1 | tee /tmp/run0.log &
	sleep 10
	"
end

bash "Build and Deploy All Source Code" do
  user "coral"
  cwd "/home/coral/opencoral"
  code "/usr/bin/ant build deploy deployAll 2>&1 | tee /tmp/deployAll1.log"
end

bash "Check for files" do
  user "coral"
  cwd "/home/coral"
  code "find /usr/local/coral 2>&1 | tee /tmp/coraldir1.log"
end

bash "Run Start Script Again to Get Athmgr to Create Key Pair" do
  user "coral"
  cwd "/home/coral"
  code "sudo /usr/local/bin/run 2>&1 | tee /tmp/run1.log &
	sleep 10 "
end

bash "Deploy All Source Code Again to Capture New Key Pair" do
  user "coral"
  cwd "/home/coral/opencoral"
  code "/usr/bin/ant deployAll 2>&1 | tee /tmp/deployAll2.log"
end

bash "Check for files" do
  user "coral"
  cwd "/home/coral"
  code "find /usr/local/coral 2>&1 | tee /tmp/coraldir2.log"
end

