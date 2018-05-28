#
# Cookbook:: workstation
# Recipe:: default
#
# Copyright:: 2017, Julien Levasseur, All Rights Reserved.

# add note about /opt/chef-solo
node['workstation']['cron']['jobs'].each do |cronjob|
  cron cronjob['name'] do # ~FC022
    hour cronjob['hour']
    minute cronjob['minute']
    command cronjob['command']
    only_if { cronjob['only_if'] } if cronjob['only_if']
    not_if { node['virtualization']['system'] == 'docker' }
  end
end

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

# node['workstation']['pip'].each do |package, version|
#   pip_package package do
#     version version
#   end
# end

node['workstation']['services'].each do |service|
  actions = []
  service['action'].each do |action|
    actions.push(action.to_sym)
  end
  service service['name'] do
    action actions
  end
end

directory '/opt/scripts'

node['workstation']['scripts'].each do |script|
  remote_file script['destination'] do
    source script['source']
    mode '0755'
  end
end

node['workstation']['symlinks'].each do |link|
  link link['from'] do
    to link['to']
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

# Vim setup:
git '/opt/Config-files' do
  repository 'https://github.com/julienlevasseur/Config-files.git'
  revision 'master'
  action :checkout
end

execute 'vim_setup' do
  cwd '/opt/Config-files'
  command '/opt/Config-files/setup-vim.sh'
end

node.save if node['virtualization']['system'] == 'docker' # ~FC075
