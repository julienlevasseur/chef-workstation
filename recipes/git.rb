#
# Cookbook:: chef-workstation
# Recipe:: git
#
# Copyright:: 2018, Julien Levasseur, All Rights Reserved.

node['workstation']['git']['config'].each do |gitconfig|
  git_config 'change system config' do
    scope 'system'
    key gitconfig['key']
    value gitconfig['value']
  end
end
