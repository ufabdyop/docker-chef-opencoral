directory "/root/.ssh"

# cookbook_file "/root/.ssh/authorized_keys" do
#   source "id_rsa.pub"
# end

directory "/home/coral/.ssh" do
  owner "coral"
  group "coral"
  mode "755"
end

# cookbook_file "/home/coral/.ssh/authorized_keys" do
#   source "id_rsa.pub"
#   owner "coral"
#   group "coral"
# end
