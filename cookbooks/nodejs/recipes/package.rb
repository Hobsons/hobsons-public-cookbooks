#
# Author:: Patrick McFadin
# Cookbook Name:: nodejs
# Recipe:: default
#
# Copyright 2010, Promet Solutions
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



case node[:platform]
  when "centos","redhat","fedora"
    package "openssl-devel"
  when "debian","ubuntu"
    package "libssl-dev"
    package "python-software-properties"
end

bash "add node.js repository" do
  cwd "/tmp"
  user "root"
  code <<-EOH
    add-apt-repository ppa:chris-lea/node.js
  EOH
  notifies :run, "execute[apt-get update]"
end

package "nodejs" do
  action :install
end
