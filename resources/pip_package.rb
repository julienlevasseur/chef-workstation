# To learn more about Custom Resources, see https://docs.chef.io/custom_resources.html
resource_name :pip_package
provides :pip_package

property :name, String, name_property: true
property :version, String

default_action :install

include Chef::Workstation::Helpers

action :install do
  unless pip_package_installed?(new_resource.name)
    converge_by "Installing '#{new_resource.name}' package" do
      begin
        system("pip install #{new_resource.name}==#{new_resource.version}")
        Chef::Log.debug("#{new_resource.name}: Installing [#{new_resource.name}==#{new_resource.version}]")
      rescue LoadError
        Chef::Log.error("Failed to install #{new_resource.name} package")
      end
    end
  end
end
