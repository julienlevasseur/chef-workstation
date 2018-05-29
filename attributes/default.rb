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

default['workstation']['terminal']['fontname']                  = 'DejaVu Sans Mono 9'
default['workstation']['terminal']['miscalwaysshowtabs']        = 'FALSE'
default['workstation']['terminal']['miscbell']                  = 'FALSE'
default['workstation']['terminal']['miscbordersdefault']        = 'TRUE'
default['workstation']['terminal']['misccursorblinks']          = 'FALSE'
default['workstation']['terminal']['misccursorshape']           = 'TERMINAL_CURSOR_SHAPE_BLOCK'
default['workstation']['terminal']['miscdefaultgeometry']       = '136x69'
default['workstation']['terminal']['miscinheritgeometry']       = 'FALSE'
default['workstation']['terminal']['miscmenubardefault']        = 'TRUE'
default['workstation']['terminal']['miscmouseautohide']         = 'FALSE'
default['workstation']['terminal']['misctoolbardefault']        = 'FALSE'
default['workstation']['terminal']['miscconfirmclose']          = 'TRUE'
default['workstation']['terminal']['misccycletabs']             = 'TRUE'
default['workstation']['terminal']['misctabclosebuttons']       = 'TRUE'
default['workstation']['terminal']['misctabclosemiddleclick']   = 'TRUE'
default['workstation']['terminal']['misctabposition']           = 'GTK_POS_TOP'
default['workstation']['terminal']['mischighlighturls']         = 'TRUE'
default['workstation']['terminal']['miscscrollalternatescreen'] = 'TRUE'
default['workstation']['terminal']['scrollinglines']            = '500000'
default['workstation']['terminal']['colorbackground']           = '#080C13'
default['workstation']['terminal']['colorforeground']           = '#EFEFEF'
