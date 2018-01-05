#
# Cookbook:: workstation
# Recipe:: users
#
# Copyright:: 2017, Julien Levasseur, All Rights Reserved.

node['workstation']['users'].each do |user|
  # SSH keys :
  ssh_key 'id_rsa' do
    path "#{user['home']}/.ssh"
    not_if { ::File.exist?("#{user['home']}/.ssh/id_rsa") }
  end

  # ~/.bashrc :
  cookbook_file "#{user['home']}/.bashrc" do
    source 'bashrc'
    owner user['name']
    group user['name']
    mode '0644'
  end
end
