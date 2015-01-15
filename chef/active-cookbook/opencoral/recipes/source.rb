execute "install source pass" do
  command "echo \"/1 :pserver:coralcvs@opencoral.mit.edu:2401/usr/local/coral-repository Atth0 y'tt\" >> /home/coral/.cvspass"
  user "coral"
end

execute "checkout source" do
  command "cvs -d :pserver:coralcvs@opencoral.mit.edu:/usr/local/coral-repository checkout -r coral-3_4_9 opencoral"
  user "coral"
  cwd "/home/coral"
  environment "HOME" => "/home/coral"
end
