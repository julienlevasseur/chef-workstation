# To learn more about Custom Resources, see https://docs.chef.io/custom_resources.html
resource_pkg_name :pip_package
provides :pip_package

property :pkg_name, String, pkg_name_property: true
property :version, String

default_action :install

include Chef::Workstation::Helpers

action :install do
  unless pip_package_installed?(new_resource.pkg_name)
    converge_by "Installing '#{new_resource.pkg_name}' package" do
      begin
        system("pip install #{new_resource.pkg_name}==#{new_resource.version}")
        Chef::Log.debug("#{new_resource.pkg_name}: Installing [#{new_resource.pkg_name}==#{new_resource.version}]")
      rescue LoadError
        Chef::Log.error("Failed to install #{new_resource.pkg_name} package")
      end
    end
  end
end
