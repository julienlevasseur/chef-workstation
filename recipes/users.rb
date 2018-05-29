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
  end

  template "#{user['home']}/.config/xfce4/terminal/terminalrc" do
    source 'terminalrc.erb'
    owner user['name']
    group user['name']
    mode 0644
    variables(
      fontname:                   node['workstation']['terminal']['fontname'],
      miscalwaysshowtabs:         node['workstation']['terminal']['miscalwaysshowtabs'],
      miscbell:                   node['workstation']['terminal']['miscbell'],
      miscbordersdefault:         node['workstation']['terminal']['miscbordersdefault'],
      misccursorblinks:           node['workstation']['terminal']['misccursorblinks'],
      misccursorshape:            node['workstation']['terminal']['misccursorshape'],
      miscdefaultgeometry:        node['workstation']['terminal']['miscdefaultgeometry'],
      miscinheritgeometry:        node['workstation']['terminal']['miscinheritgeometry'],
      miscmenubardefault:         node['workstation']['terminal']['miscmenubardefault'],
      miscmouseautohide:          node['workstation']['terminal']['miscmouseautohide'],
      misctoolbardefault:         node['workstation']['terminal']['misctoolbardefault'],
      miscconfirmclose:           node['workstation']['terminal']['miscconfirmclose'],
      misccycletabs:              node['workstation']['terminal']['misccycletabs'],
      misctabclosebuttons:        node['workstation']['terminal']['misctabclosebuttons'],
      misctabclosemiddleclick:    node['workstation']['terminal']['misctabclosemiddleclick'],
      misctabposition:            node['workstation']['terminal']['misctabposition'],
      mischighlighturls:          node['workstation']['terminal']['mischighlighturls'],
      miscscrollalternatescreen:  node['workstation']['terminal']['miscscrollalternatescreen'],
      scrollinglines:             node['workstation']['terminal']['scrollinglines'],
      colorbackground:            node['workstation']['terminal']['colorbackground'],
      colorforeground:            node['workstation']['terminal']['colorforeground']
    )
  end

  # Give access to docker to user:
  execute "Give access to Docker to #{user}['name']" do
    command 'USERID=`id -u`;usermod -a -G docker $USERID'
    not_if "grep docker /etc/group|grep #{user}['name']"
    not_if { node['virtualization']['system'] == 'docker' }
  end
end
