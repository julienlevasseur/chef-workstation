name 'workstation'
maintainer 'Julien Levasseur'
maintainer_email 'contact@julienlevasseur.ca'
license 'MIT'
description 'Installs/Configures workstation'
long_description 'Installs/Configures workstation'
version '0.1.0'
chef_version '>= 12.1' if respond_to?(:chef_version)

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
issues_url 'https://github.com/julienlevasseur/workstation/issues'

# The `source_url` points to the development repository for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
source_url 'https://github.com/julienlevasseur/workstation'

depends 'consul-template'
depends 'ssh'

supports 'debian'
supports 'ubuntu'
