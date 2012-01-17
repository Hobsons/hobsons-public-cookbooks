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
include_recipe "build-essential"

if platform?("redhat", "centos", "fedora")
  # code for only redhat family systems.
  	%w{ curl-devel libxml2-devel openssl-devel mailcap}.each do |pkg|
  		package pkg
	end
	
	package "fuse*" do
		action :remove
	end
end
 
if platform?("ubuntu")
  	# code for only ubuntu systems
	%w{ pkg-config libcurl4-openssl-dev }.each do |pkg|
  		package pkg
	end

	package "fuse-utils" do
		action :remove
	end

	package "libfuse2" do
		action :remove
	end

	package "fuse" do
		action :remove
	end
end

remote_file "/tmp/fuse-2.8.4.tar.gz" do
  source "http://iweb.dl.sourceforge.net/project/fuse/fuse-2.X/2.8.4/fuse-2.8.4.tar.gz"
  mode 0644
end

remote_file "/tmp/s3fs-1.61.tar.gz" do
  source "http://s3fs.googlecode.com/files/s3fs-1.61.tar.gz"
  mode 0644
end

bash "install fuse" do
  cwd "/tmp"
  code <<-EOH
  tar zxvf fuse-2.8.4.tar.gz
  cd fuse-2.8.4
  ./configure --prefix=/usr
  make
  make install
  ldconfig
  EOH
end

bash "install s3fs" do
  cwd "/tmp"
  code <<-EOH
  tar zxvf s3fs-1.61.tar.gz
  cd s3fs-1.61
  export PKG_CONFIG_PATH=/usr/lib/pkgconfig
  ./configure
  make
  make install
  EOH
  not_if { File.exists?("/usr/bin/s3fs") }
end