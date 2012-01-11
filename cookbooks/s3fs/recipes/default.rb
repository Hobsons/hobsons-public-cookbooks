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
%w{ pkg-config libcurl4-openssl-dev libfuse-dev libfuse2 }.each do |pkg|
  package pkg
end

remote_file "/tmp/s3fs-1.61.tar.gz" do
  source "http://s3fs.googlecode.com/files/s3fs-1.61.tar.gz"
  mode 0644
end

bash "install s3fs" do
  cwd "/tmp"
  code <<-EOH
  tar zxvf s3fs-1.61.tar.gz
  cd s3fs-1.61
  configure
  make
  make install
  EOH
  
  not_if { File.exists?("/usr/bin/s3fs") }
end