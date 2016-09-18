#
# Cookbook Name:: thumbor_ng
# Recipe:: cron
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

directory "#{node['thumbor_ng']['options']['FILE_STORAGE_ROOT_PATH']}_purge" do
  owner node['thumbor_ng']['user']
  group node['thumbor_ng']['group']
  mode 0o755
  recursive true
  only_if { node['thumbor_ng']['options']['FILE_STORAGE_ROOT_PATH'] != 'None' }
end

case node['thumbor_ng']['init_style']
when 'init'
  start_command = "/etc/init.d/#{node['thumbor_ng']['service_name']} start"
  stop_command = "/etc/init.d/#{node['thumbor_ng']['service_name']} stop"
when 'upstart'
  start_command = "/sbin/start #{node['thumbor_ng']['service_name']} "
  stop_command = "/sbin/stop #{node['thumbor_ng']['service_name']} "
end

cron_d 'thumbor_purge_file_storage' do
  minute node['thumbor_ng']['cron']['minute']
  hour node['thumbor_ng']['cron']['hour']
  day node['thumbor_ng']['cron']['day']
  weekday node['thumbor_ng']['cron']['weekday']
  month node['thumbor_ng']['cron']['month']
  path node['thumbor_ng']['cron']['path']
  shell node['thumbor_ng']['cron']['shell']
  user node['thumbor_ng']['cron']['user']
  mailto node['thumbor_ng']['cron']['mailto']
  home node['thumbor_ng']['cron']['home']

  command "rm -fr #{node['thumbor_ng']['options']['FILE_STORAGE_ROOT_PATH']}_purge/*; #{stop_command}; mv #{node['thumbor_ng']['options']['FILE_STORAGE_ROOT_PATH']}/* #{node['thumbor_ng']['options']['FILE_STORAGE_ROOT_PATH']}_purge/; #{start_command}; rm -fr #{node['thumbor_ng']['options']['FILE_STORAGE_ROOT_PATH']}_purge/*"
  action node['thumbor_ng']['cron']['action']
  only_if { node['thumbor_ng']['options']['FILE_STORAGE_ROOT_PATH'] != 'None' }
end
