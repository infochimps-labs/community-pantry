#
# Cookbook Name::       ganglia
# Description::         Ganglia agent -- discovers and sends to its ganglia_server
# Recipe::              agent
# Author::              Chris Howe - Infochimps, Inc
#
# Copyright 2011, Chris Howe - Infochimps, Inc
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'ganglia'
include_recipe 'runit'

daemon_user('ganglia.agent')

package "ganglia-monitor"

standard_dirs('ganglia.agent') do
  directories [:home_dir, :log_dir, :conf_dir, :pid_dir, :data_dir]
end

#
# Create service
#

kill_old_service('ganglia-monitor'){ pattern 'gmond' }

runit_service "ganglia_agent" do
  run_state     node[:ganglia][:agent][:run_state]
  options       Mash.new(node[:ganglia].to_hash).merge(node[:ganglia][:agent].to_hash)
end

#
# Discover ganglia server, construct conf file
#

announce(:ganglia, :agent, {
  :monitor_group => node[:cluster_name],
  :ports => {
    :send_port => { :port => node[:ganglia][:send_port], :protocol =>'http'},
  },
  :daemons => {
    :gmond => { :name => 'gmond', :user =>node[:ganglia][:user]},
  },
})
