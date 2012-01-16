#
# Cookbook Name:: s3fs
# Recipe:: default
#
# Copyright 2012, Hobsons
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

#include_recipe "s3fs::default"

bash "create passwd file" do
	cwd "/root"
	code <<-EOH
	echo "#{ node[:s3fs][:aws_access_key_id] }:#{ node[:s3fs][:aws_secret_access_key] }" > .passwd-s3fs
	chmod 600 .passwd-s3fs
	EOH

end

directory node[:s3fs][:mount_point] do
  owner "root"
  group "root"
  mode "0755"
  action :create
  not_if { File.exists?(node[:s3fs][:mount_point]) }
end

bash "mount s3fs" do
  cwd "/tmp"
  code <<-EOH
  /usr/local/bin/s3fs #{ node[:s3fs][:s3_bucket_name] } -o allow_other /#{ node[:s3fs][:mount_point] } > /tmp/s3fs.log
  EOH
  
  not_if { File.exists?("/usr/local/bin/s3fs") }
end