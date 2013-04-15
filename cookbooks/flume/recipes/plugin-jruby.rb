#
# Cookbook Name::       flume
# Description::         Jruby Plugin
# Recipe::              jruby_plugin
# Author::              Chris Howe - Infochimps, Inc
#
# Copyright 2011, Infochimps, Inc.
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

directory File.join(node[:flume][:home_dir], 'plugins') do
  owner node[:flume][:user]
  group node[:flume][:user]
  mode  '0755'
end 

cookbook_file "#{node[:flume][:home_dir]}/plugins/jruby-flume-#{node[:flume][:jars][:jruby_jar_version]}.jar" do
  source "jruby-flume-#{node[:flume][:jars][:jruby_jar_version]}.jar"
  owner "flume"
  mode "0644"
end

directory "#{node[:flume][:home_dir]}/scripts" do
  owner "flume"
  mode "0755"
end

node[:flume][:plugins][:jruby_flume] ||= {}
node[:flume][:plugins][:jruby_flume][:classes]    = [ "com.infochimps.flume.jruby.JRubySink",
                                                      "com.infochimps.flume.jruby.JRubySource",
                                                      "com.infochimps.flume.jruby.JRubyDecorator", 
						      "com.infochimps.flume.SQLSink", ]
node[:flume][:plugins][:jruby_flume][:classpath]  = [ "#{node[:flume][:home_dir]}/plugins/jruby-flume-#{node[:flume][:jars][:jruby_jar_version]}.jar","#{node[:jruby][:home_dir]}/lib/jruby.jar" ]
node[:flume][:plugins][:jruby_flume][:java_opts]  = [ "-Djruby.home=#{node[:jruby][:home_dir]}",
                                                      "-Djruby.lib=#{node[:jruby][:home_dir]}/lib",
                                                      "-Djruby.script=jruby", ]

node[:flume][:exported_jars] += [
  "#{node[:flume][:home_dir]}/plugins/jruby-flume-#{node[:flume][:jars][:jruby_jar_version]}.jar",
]

node_changed!
