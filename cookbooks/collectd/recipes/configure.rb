daemon_user "collectd"

standard_dirs "collectd" do
  directories :conf_dir, :pid_dir, :home_dir
end

directory File.join(node[:collectd][:conf_dir], "plugins") do
  action    :create
  recursive true
end

runit_service "collectd"

template File.join(node[:collectd][:conf_dir], "collectd.conf") do
  source    "collectd.conf.erb"
  mode      '0665'
  action    :create

  notifies  :restart, "service[collectd]", :delayed
end

node[:collectd][:plugins].each do |name|
  variables = {}

  if name.to_s == "cube"
    cube = discover(:cube, :collector)
    variables.merge!(:cube => {
      :host => cube.private_ip,
      :port => cube.ports["http"]["port"]
    })
  end

  cube = discover(:cube, :collector)
  template File.join(node[:collectd][:conf_dir], "plugins", "#{name}.conf") do
    source    "plugins/#{name}.conf.erb"
    mode      '0665'
    action    :create
    variables variables
    notifies  :restart, "service[collectd]", :delayed
  end
end
