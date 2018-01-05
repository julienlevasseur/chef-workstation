#
# Cookbook:: workstation
# Recipe:: default
#
# Copyright:: 2017, Julien Levasseur, All Rights Reserved.

# Consul (binary + service)
# Nomad (binary + service)
# Vault (binary + service)

cron 'chef-solo-run' do
  hour '*'
  minute '*/15'
  command 'cd /opt/chef-solo/ && /opt/chef-solo/run.sh > /var/log/chef-solo.log'
  only_if { ::Dir.exist?('/opt/chef-solo') }
end

# Install packages :
apt_update if node['platform_family'] == 'debian'

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
include_recipe 'workstation::ubuntu' if node['platform'] == 'ubuntu'
include_recipe 'consul-template::default'

node['workstation']['ssh_config'].each do |ssh_config|
  ssh_config ssh_config['name'] do
    options ssh_config['options']
    user ssh_config['user']
  end
end
