# workstation

Install and configure workstation.

#Supports

- Debian like distributions
- 

#Usage

Make your wrapper cookbook dependant of this one:

metadata.rb:
```ruby
depends 'workstation'
```


default.rb:
```ruby
include_recipe 'workstation::default'
```

Or, call it from your Chef-Solo package:

attribute.json
```json
"run_list": ["recipe[workstation::default]"]
```

## Chef-Solo setup

Edit the `attributes.json` file:
```json
{
	"workstation": {
        "packages": [
            "vim",
            "git",
            ...
        ],
        "gems": [
            "bundler",
            "rake",
            "inspec",
            "ohai",
            "chef",
            "docker",
            "test-kitchen",
            "kitchen-docker",
            "kitchen-ansible"
        ],
		"users": [
			{
				"name": "USERNAME",
				"home": "/home/USERNAME"
			}
		],
		"hosts": [
			{"127.0.1.1": "HOSTNAME"}
		],
        "ssh_config": [
            {
                "name": "bastion",
                "options": {
                    "HostName": "1.2.3.4",
                    "User": "cloud-user",
                    "IdentityFile": "~/.ssh/cloud-user"
                },
                "user": "USERNAME"
            }
        ]
	}
}
```

- `packages` - List of system packages to install
- `gems` - List of gems to install
- `pip` - List of pip packages to install ("pkg_name": "pkg_version")
- `users` - List of users you want to manage (username and home folder)
- `hosts` - Content of `/etc/hosts`
- `ssh_config` - The SSH config per user

When you're ready to let `workstation` cookbook manage you workstation, just create a /opt/chef-solo folder :

```bash
ln -s /home/$USER/repos/workstation-chef-solo /opt/chef-solo
```

With this folder, the workstation cookbook will setup a crontab to run the chef-solo runner every 15 minutes, ensuring that your workstation is setup as excepted all the time.
