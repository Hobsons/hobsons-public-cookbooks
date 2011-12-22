#
# Cookbook Name:: flume
# Recipe:: default
#
# Copyright 2011, Hobsons
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

# Get the archive key for cloudera package repo
execute "curl -s http://archive.cloudera.com/debian/archive.key | apt-key add -" do
  not_if "apt-key export 'Cloudera Apt Repository' | grep 'BEGIN PGP PUBLIC KEY'"
  notifies :run, "execute[apt-get update]"
end

# Add cloudera package repo
apt_repository 'cloudera' do
  uri             'http://archive.cloudera.com/debian'
  distro        = node[:lsb][:codename]
  distribution    "#{distro}-#{node[:hadoop][:cdh_version]}"
  components      ['contrib']
  key             "http://archive.cloudera.com/debian/archive.key"
  action          :add
end

#
# Install package
#

package "flume"

template "/usr/lib/flume/conf/flume-site.xml" do
  source "flume-site.xml.erb"
  owner  "root"
  group  "flume"
  mode   "0644"
  variables({
      :masters            => flume_masters.join(","),
      :plugin_classes     => flume_plugin_classes,
      :classpath          => flume_classpath,
      :master_id          => flume_master_id,
      :external_zookeeper => flume_external_zookeeper,
      :zookeepers         => flume_zookeeper_list,
      :aws_access_key     => node[:flume][:aws_access_key],
      :aws_secret_key     => node[:flume][:aws_secret_key],
      :collector_output_format =>
      node[:flume][:collector][:output_format],
      :collector_codec     => node[:flume][:collector][:codec],
      :flume_data_dir      => node[:flume][:data_dir]
    })
end

template "/usr/lib/flume/bin/flume-env.sh" do
  source "flume-env.sh.erb"
  owner  "root"
  mode   "0744"
  variables({
      :classpath          => flume_classpath,
      :java_opts          => flume_java_opts,
    })
end