default['workstation']['chef-solo']['daemon-run-interval'] = 1800

# Users to configure:
default['workstation']['users'] = []

default['workstation']['cron']['jobs'] = [
  {
    name: 'chef-solo-run',
    hour: '*',
    minute: '0',
    command: 'cd /opt/chef-solo/ && /opt/chef-solo/run.sh > /var/log/chef-solo.log',
    only_if: ::Dir.exist?('/opt/chef-solo'),
  },
]

default['workstation']['debian']['repos'] = []

# system packages
default['workstation']['packages'] = %w(
  vim
  git
  npm
)

default['workstation']['packages_to_remove'] = []

# gem packages
default['workstation']['gems'] = %w(
  bundler
  rake
)

# pip packages
default['workstation']['pip'] = {
  'ansible' => '2.3.2.0',
  'pyOpenSSL' => '17.5.0',
}

default['workstation']['services'] = []
# {
#   name: 'foo',
#   action: [:enabled, :started]
#  }

default['workstation']['scripts'] = []

default['workstation']['symlinks'] = []

# /etc/hosts
default['workstation']['hosts'] = []

# SSH config:
default['workstation']['ssh_config'] = []
# {
#   name: "foo",
#   options: {},
#   user: "suername"
# }

default['workstation']['customize_git'] = true
# System wide git config :
default['workstation']['git']['config'] = [
  {
    key: 'color.ui',
    value: 'auto',
  },
  {
    key: 'pull.rebase',
    value: 'true',
  },
]

default['workstation']['terminal'] = {
  fontname: 'DejaVu Sans Mono 9',
  miscalwaysshowtabs: 'FALSE',
  miscbell: 'FALSE',
  miscbordersdefault: 'TRUE',
  misccursorblinks: 'FALSE',
  misccursorshape: 'TERMINAL_CURSOR_SHAPE_BLOCK',
  miscdefaultgeometry: '136x70',
  miscinheritgeometry: 'FALSE',
  miscmenubardefault: 'TRUE',
  miscmouseautohide: 'FALSE',
  misctoolbardefault: 'FALSE',
  miscconfirmclose: 'TRUE',
  misccycletabs: 'TRUE',
  misctabclosebuttons: 'TRUE',
  misctabclosemiddleclick: 'TRUE',
  misctabposition: 'GTK_POS_TOP',
  mischighlighturls: 'TRUE',
  miscscrollalternatescreen: 'TRUE',
  scrollinglines: '500000',
  colorbackground: '#080C13',
  colorforeground: '#EFEFEF',
}
