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

default['workstation']['terminal']['config'] = [
  {
    key: 'FontName',
    value: 'DejaVu Sans Mono 9',
  },
  {
    key: 'MiscAlwaysShowTabs',
    value: 'FALSE',
  },
  {
    key: 'MiscBell',
    value: 'FALSE',
  },
  {
    key: 'MiscBordersDefault',
    value: 'TRUE',
  },
  {
    key: 'MiscCursorBlinks',
    value: 'FALSE',
  },
  {
    key: 'MiscCursorShape',
    value: 'TERMINAL_CURSOR_SHAPE_BLOCK',
  },
  {
    key: 'MiscDefaultGeometry',
    value: '136x69',
  },
  {
    key: 'MiscInheritGeometry',
    value: 'FALSE',
  },
  {
    key: 'MiscMenubarDefault',
    value: 'TRUE',
  },
  {
    key: 'MiscMouseAutohide',
    value: 'FALSE',
  },
  {
    key: 'MiscToolbarDefault',
    value: 'FALSE',
  },
  {
    key: 'MiscConfirmClose',
    value: 'TRUE',
  },
  {
    key: 'MiscCycleTabs',
    value: 'TRUE',
  },
  {
    key: 'MiscTabCloseButtons',
    value: 'TRUE',
  },
  {
    key: 'MiscTabCloseMiddleClick',
    value: 'TRUE',
  },
  {
    key: 'MiscTabPosition',
    value: 'GTK_POS_TOP',
  },
  {
    key: 'MiscHighlightUrls',
    value: 'TRUE',
  },
  {
    key: 'MiscScrollAlternateScreen',
    value: 'TRUE',
  },
  {
    key: 'ScrollingLines',
    value: '500000',
  },
  {
    key: 'ColorBackground',
    value: '#080C13',
  },
  {
    key: 'ColorForeground',
    value: '#EFEFEF',
  },
]

default['workstation']['touchpad'] = :disabled
