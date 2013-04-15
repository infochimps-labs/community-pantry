default[:ganglia][:home_dir]         = '/var/lib/ganglia'
default[:ganglia][:conf_dir]         = '/etc/ganglia'
default[:ganglia][:pid_dir]          = '/var/run/ganglia'
default[:ganglia][:data_dir]         = "#{node[:ganglia][:home_dir]}/rrds"
default[:ganglia][:agent ][:log_dir] = '/var/log/ganglia/agent'
default[:ganglia][:server][:log_dir] = '/var/log/ganglia/server'

default[:ganglia][:user]             = 'ganglia'
default[:users ]['ganglia'][:uid]    = 320
default[:groups]['ganglia'][:gid]    = 320

default[:ganglia][:send_port]        = 8649
default[:ganglia][:rcv_port ]        = 8649

default[:ganglia][:agent ][:run_state] = :start
default[:ganglia][:server][:run_state] = :start
