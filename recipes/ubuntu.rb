#
# Cookbook:: workstation
# Recipe:: ubuntu
#
# Copyright:: 2017, Julien Levasseur, All Rights Reserved.

cookbook_file '/opt/display_manager.py' do
  source 'display_manager.py'
  owner 'root'
  group 'root'
  mode '0755'
end
