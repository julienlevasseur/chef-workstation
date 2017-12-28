# # encoding: utf-8

# Inspec test for recipe workstation::default

require 'json'

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

node = json("/home/levasju1/repos/bitbucket/chef-solo_playground/nodes/LAP-MTL-LEVASJU.vasco.com.json").params

#describe crontab('root') do
#  its('commands') { should include 'cd /opt/chef-solo' }
#end

#packages.each do |pkg|
node['normal']['workstation']['packages'].each do |pkg|
  describe package(pkg.strip) do
    it { should be_installed }
  end
end

node['normal']['workstation']['gems'].each do |g|
  describe gem(g) do
    it { should be_installed }
  end
end

node['default']['workstation']['pip'].each do |name, version|
  describe pip(name) do
    it { should be_installed }
    its('version') { should eq version }
  end
end

describe file('/etc/hosts') do
  it { should exist }
  it { should be_file }
  its('mode') { should cmp '0644' }
  its('owner') { should eq 'root' }
  its('group') { should eq 'root' }
end

describe file('/opt/display_manager.py') do
  it { should exist }
  it { should be_file }
  its('mode') { should cmp '0755' }
  it { should be_executable }
  its('owner') { should eq 'root' }
  its('group') { should eq 'root' }
  its('md5sum') { should eq '9012f87573a4e1cd14d5b528aae9f201' }
end


node['normal']['workstation']['ssh_config'].each do |ssh_config|
  describe ssh_config("/home/#{ssh_config['user']}/.ssh/config") do
    #its('owner') { should match(ssh_config['user']) }
    its('Host') { should eq ssh_config['name'] }
    its('HostName') { should eq ssh_config['options']['HostName'] }
    its('IdentityFile') { should eq ssh_config['options']['IdentityFile'] }
    its('User') { should eq ssh_config['options']['User'] }
  end
end