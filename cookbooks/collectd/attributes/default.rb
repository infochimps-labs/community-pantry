# Install
default[:collectd][:deploy_version] = "master"
default[:collectd][:git_url]        = "git://github.com/collectd/collectd.git"

# standard_dirs
default[:collectd][:home_dir]       = "/usr/local/share/collectd"
default[:collectd][:conf_dir]       = "/etc/collectd"
default[:collectd][:log_dir]        = "/var/log/collectd"
default[:collectd][:pid_dir]        = "/var/run/collectd"

# daemon_user
default[:collectd][:user]           = "collectd"
default[:collectd][:group]          = "collectd"
default[:users ]['collectd'][:uid]  = 450
default[:groups]['collectd'][:gid]  = 450

default[:collectd][:plugins]  = []
default[:collectd][:interval] = 10