execute "Deploy build artifacts" do
  cwd "/opencoral"
  command "source ~/.bashrc; /usr/local/ant-1.8.2/bin/ant deployAll -DdontTouchDatabase=true"
end
