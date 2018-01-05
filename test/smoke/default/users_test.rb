# # encoding: utf-8

# Inspec test for recipe workstation::users

require 'json'

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

node = json('/home/levasju1/repos/bitbucket/chef-solo_playground/nodes/LAP-MTL-LEVASJU.vasco.com.json').params

node['normal']['workstation']['users'].each do |user|
  describe file("#{user['home']}/.ssh/id_rsa") do
    it { should exist }
    it { should be_owned_by user['name'] }
  end
end
