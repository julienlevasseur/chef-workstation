#
# Cookbook:: workstation
# Recipe:: users
#
# Copyright:: 2017, Julien Levasseur, All Rights Reserved.

node['workstation']['users'].each do |user|
  # SSH keys :
  ssh_key 'id_rsa' do # ~FC022
    path "#{user['home']}/.ssh"
    not_if { ::File.exist?("#{user['home']}/.ssh/id_rsa") }
  end
end
