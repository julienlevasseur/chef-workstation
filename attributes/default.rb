# Users to configure:
default['workstation']['users'] = []

# system packages
default['workstation']['packages'] = %w(
  vim
  git
  npm
)

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

# /etc/hosts
default['workstation']['hosts'] = []

# SSH config:
default['workstation']['ssh_config'] = []
# {
#   name: "foo",
#   options: {},
#   user: "suername"
# }
