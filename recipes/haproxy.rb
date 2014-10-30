#
# Cookbook Name:: thumbor_ng
# Recipe:: haproxy
#
# Copyright 2014, Virender Khatri
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

# include_recipe 'haproxy'

# template node['thumbor_ng']['haproxy']['config_file'] do
#  cookbook node['thumbor_ng']['haproxy']['cookbook']
#  source node['thumbor_ng']['haproxy']['template']
#  owner 'root'
#  group 'root'
#  mode '0644'
#  variables ( node['thumbor_ng']['haproxy']['variables'].empty? ? { :instances => node['thumbor_ng']['processes'],
#                                                                 :base_port            => node['thumbor_ng']['base_port'],
#                                                                 :server_port          => node['thumbor_ng']['haproxy']['port'],
#                                                               } : node['thumbor_ng']['haproxy']['variables']
#            )
# end
