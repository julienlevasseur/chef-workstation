#
# Cookbook:: workstation
# Recipe:: default
#
# Copyright:: 2017, Julien Levasseur, All Rights Reserved.

# Consul (binary + service)
# Nomad (binary + service)
# Vault (binary + service)

# add note about /opt/chef-solo

cron 'chef-solo-run' do
  hour '*'
  minute '*/30'
  command 'cd /opt/chef-solo/ && /opt/chef-solo/run.sh > /var/log/chef-solo.log'
  only_if { ::Dir.exist?('/opt/chef-solo') }
end

#
# Manage Chef-Solo daemon :
#
# Create the chef-solo service file :
# template '/lib/systemd/system/chef-solo.service' do
#   source 'chef-solo.service.erb'
#   owner 'root'
#   group 'root'
#   mode '0644'
#   variables(
#     interval: node['workstation']['chef-solo']['daemon-run-interval']
#   )
# end
#
# # Link the Chef-Solo service file from /lib to /etc :
# link '/lib/systemd/system/chef-solo.service' do
#   to '/etc/systemd/system/multi-user.target.wants/chef-solo.service'
# end
#
# # Enable and start Chef-Solo daemon :
# service 'chef-solo' do
#   action [:enable, :start]
# end

if node['platform'] == 'ubuntu' || node['platform'] == 'debian'
  include_recipe 'workstation::debian' if node['platform_family'] == 'debian'
elsif node['platform'] == 'Darwin'
  include_recipe 'workstation::macos'
end

# Install packages :
node['workstation']['packages'].each do |pkg|
  package pkg
end

node['workstation']['gems'].each do |g|
  gem_package g do
    action :install
    not_if "gem list|grep #{g}"
  end
end

node['workstation']['pip'].each do |package, version|
  pip_package package do
    version version
  end
end

directory '/opt/scripts'

node['workstation']['scripts'].each do |script|
  remote_file script['destination'] do
    source script['source']
    mode '0755'
  end
end

template '/etc/hosts' do
  source 'hosts.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables(
    hosts: node['workstation']['hosts']
  )
end

include_recipe 'workstation::users'
include_recipe 'workstation::git' if node['workstation']['customize_git'] == true
# include_recipe 'consul-template::default'

node['workstation']['ssh_config'].each do |ssh_config|
  ssh_config ssh_config['name'] do
    options ssh_config['options']
    user ssh_config['user']
  end
end
