#
# Chef Documentation
# https://docs.chef.io/libraries.html
#

#
# This module name was auto-generated from the cookbook name. This name is a
# single word that starts with a capital letter and then continues to use
# camel-casing throughout the remainder of the name.
#
module Workstation
  module Helpers
    def pip_package_installed?(package_name)
      cmd = Mixlib::ShellOut.new("pip list --format=columns|grep #{package_name}")
      # return true if system "pip list --format=columns|grep #{package_name}"
      return true if cmd.run_command
    end
  end
end

#
# The module you have defined may be extended within the recipe to grant the
# recipe the helper methods you define.
#
# Within your recipe you would write:
#
#     extend Workstation::Helpers
#
#     my_helper_method
#
# You may also add this to a single resource within a recipe:
#
#     template '/etc/app.conf' do
#       extend Workstation::Helpers
#       variables specific_key: my_helper_method
#     end
#
