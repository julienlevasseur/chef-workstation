# To learn more about Custom Resources, see https://docs.chef.io/custom_resources.html
resource_name :pip_package
provides :pip_package

property :pkg_name, String, name_property: true
property :version, String

default_action :install

include Chef::Workstation::Helpers

action :install do
  unless pip_package_installed?(new_resource.pkg_name)
    converge_by "Installing '#{new_resource.pkg_name}' package" do
      begin
        if :version
          system("pip install #{new_resource.pkg_name}==#{new_resource.version}")
        else
          system("pip install #{new_resource.pkg_name}")
        end
        Chef::Log.debug("#{new_resource.pkg_name}: Installing [#{new_resource.pkg_name}==#{new_resource.version}]")
      rescue LoadError
        Chef::Log.error("Failed to install #{new_resource.pkg_name} package")
      end
    end
  end
end
