bash "set up coralapiserver to start with runit" do
  code <<-EOF
    mkdir /var/log/coralapiserver
    chown coral /var/log/coralapiserver
    cd /home/coral/coralapiserver
    git pull origin master
    sudo ln -s /home/coral/coralapiserver/runit /etc/service/coralapiserver
  EOF
end

cookbook_file "/usr/local/bin/run" do
  mode "0755"
  user "root"
  source "run.sh"
end
