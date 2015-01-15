execute "Use dev DB config" do
  cwd "/opencoral/config"
  command "cp .jspw-dev.properties .jspw.properties"
end

execute "Use dev config" do
  cwd "/opencoral/config"
  command "cp nanofab.utah.edu-dev.properties nanofab.utah.edu-prod.properties"
end

execute "Build java files" do
  cwd "/opencoral"
  command "source ~/.bashrc; /usr/local/ant-1.8.2/bin/ant build"
end
