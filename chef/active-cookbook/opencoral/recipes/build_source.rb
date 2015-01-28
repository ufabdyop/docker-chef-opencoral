cookbook_file "/home/coral/opencoral/ext/proguard/proguard-5.1.jar" do
  source "proguard-5.1.jar"
  owner "coral"
  group "opencoral"
end

cookbook_file "/home/coral/opencoral/ext/proguard/proguardgui-5.1.jar" do
  source "proguardgui-5.1.jar"
  owner "coral"
  group "opencoral"
end

cookbook_file "/home/coral/opencoral/ext/proguard/retrace-5.1.jar" do
  source "retrace-5.1.jar"
  owner "coral"
  group "opencoral"
end

execute "set new version of proguard" do
  command "perl -i -pe 's/4.4/5.1/' /home/coral/opencoral/config/.hidden.properties"
end

bash "Build java files" do
  user "coral"
  cwd "/home/coral/opencoral"
  code "/usr/local/ant-1.8.2/bin/ant build | tee /tmp/build0.log"
end
