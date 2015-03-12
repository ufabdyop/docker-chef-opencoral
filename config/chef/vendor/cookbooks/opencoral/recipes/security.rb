#
# Cookbook Name:: opencoral
# Recipe:: database-config
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

cookbook_file "/tmp/unlimited.zip" do
  source "unlimited7.zip"
  mode "0644"
end

bash "unzip unlimited" do
  code <<-EOF 
	cd /tmp; 
	unzip unlimited7.zip; 
	cd UnlimitedJCEPolicy/;
	cp *jar /usr/lib/jvm/default-java/jre/lib/security/
	rm -rf /tmp/unlimited7.zip /tmp/UnlimitedJCEPolicy
  EOF
end

bash "add provider" do
  code <<-EOF 
	echo 'security.provider.11=org.bouncycastle.jce.provider.BouncyCastleProvider' >> /usr/lib/jvm/default-java/jre/lib/security/java.security
	cp /home/coral/opencoral/ext/jce/bcprov-jdk15on-150.jar /usr/lib/jvm/default-java/jre/lib/ext/
  EOF
end
