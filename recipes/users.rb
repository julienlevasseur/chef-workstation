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

  # Terminal customization:
  directory "#{user['home']}/.config/xfce4/terminal" do
    owner user['name']
    group user['name']
    mode 0755
    action :create
    recursive true
  end

  template "#{user['home']}/.config/xfce4/terminal/terminalrc" do
    source 'terminalrc.erb'
    owner user['name']
    group user['name']
    mode 0644
    variables(
      config: node['workstation']['terminal']['config']
    )
  end

  # Give access to docker to user:
  # TODO : Refactor with group resource !
  # execute "Give access to Docker to #{user}['name']" do
  #   command 'USERID=`id -u`;usermod -a -G docker $USERID'
  #   not_if "grep docker /etc/group|grep #{user}['name']"
  #   not_if { node['virtualization']['system'] == 'docker' }
  # end
end
