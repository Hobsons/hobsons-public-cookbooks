#
# Cookbook Name::       flume
# Description::         Node
# Recipe::              node
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

# We need to explicitly include the default recipe, because we need access
# to the templates.
include_recipe "flume::default"

package "flume-node" 

service "flume-node" do
  supports :restart => true, :start=>true, :stop => true
  subscribes :restart,resources( :template => ["/usr/lib/flume/conf/flume-site.xml","/usr/lib/flume/bin/flume-env.sh"] )
end

provide_service ("#{node[:flume][:cluster_name]}-flume-node")
