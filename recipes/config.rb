#
# Cookbook Name:: thumbor_ng
# Recipe:: config
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

# thumbor service user limit
user_ulimit node['thumbor_ng']['user'] do
  filehandle_limit node['thumbor_ng']['limits']['nofile']
  process_limit node['thumbor_ng']['limits']['nproc']
  memory_limit node['thumbor_ng']['limits']['memlock']
end

# thumbor upstart log directory
directory node['thumbor_ng']['log_dir'] do
  owner node['thumbor_ng']['user']
  group node['thumbor_ng']['group']
  recursive true
  notifies :restart, 'service[thumbor]', :delayed if node['thumbor_ng']['notify_restart']
end

# may require different logrotate for different init_style
template '/etc/logrotate.d/thumbor' do
  owner 'root'
  group 'root'
  mode 0644
  source 'thumbor.logrotate.erb'
  variables(:log_dir => node['thumbor_ng']['log_dir'],
            :rotate => node['thumbor_ng']['logrotate']['rotate']
           )
end

# thumbor storage directory
directory node['thumbor_ng']['options']['FILE_STORAGE_ROOT_PATH'] do
  owner node['thumbor_ng']['user']
  group node['thumbor_ng']['group']
  mode 0755
  recursive true
  notifies :restart, 'service[thumbor]', :delayed if node['thumbor_ng']['notify_restart']
end

# thumbor result storage directory
directory node['thumbor_ng']['options']['RESULT_STORAGE_FILE_STORAGE_ROOT_PATH'] do
  owner node['thumbor_ng']['user']
  group node['thumbor_ng']['group']
  mode 0755
  recursive true
  notifies :restart, 'service[thumbor]', :delayed if node['thumbor_ng']['notify_restart']
end

ruby_block 'require_pam_limits.so' do
  block do
    fe = Chef::Util::FileEdit.new('/etc/pam.d/su')
    fe.search_file_replace_line(/# session    required   pam_limits.so/, 'session    required   pam_limits.so')
    fe.write_file
  end
end

# thumbor upstart init configuration files
template '/etc/init/thumbor.conf' do
  source 'thumbor.upstart.erb'
  owner 'root'
  group 'root'
  mode '0755'
  notifies :restart, 'service[thumbor]', :delayed if node['thumbor_ng']['notify_restart']
  variables(:service_config_file => node['thumbor_ng']['service_config_file'])
  only_if { node['thumbor_ng']['init_style'] == 'upstart' }
end

template '/etc/init/thumbor-worker.conf' do
  source 'thumbor-worker.upstart.erb'
  owner 'root'
  group 'root'
  mode '0755'
  variables(:upstart_respawn => node['thumbor_ng']['upstart_respawn'],
            :user => node['thumbor_ng']['user'],
            :group => node['thumbor_ng']['group'],
            :binary => node['thumbor_ng']['binary'],
            :key_file => node['thumbor_ng']['key_file'],
            :conf_file => node['thumbor_ng']['conf_file'],
            :log_dir => node['thumbor_ng']['log_dir'],
            :listen_address => node['thumbor_ng']['listen_address'],
            :log_level => node['thumbor_ng']['log_level'],
            :filehandle_limit => node['thumbor_ng']['limits']['nofile'],
            :process_limit => node['thumbor_ng']['limits']['nproc'],
            :memory_limit => node['thumbor_ng']['limits']['memlock']
           )
  notifies :restart, 'service[thumbor]', :delayed if node['thumbor_ng']['notify_restart']
  only_if { node['thumbor_ng']['init_style'] == 'upstart' }
end

template node['thumbor_ng']['service_config_file'] do
  source 'thumbor.config.erb'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[thumbor]', :delayed if node['thumbor_ng']['notify_restart']
  variables(:workers => node['thumbor_ng']['workers'],
            :base_port => node['thumbor_ng']['base_port'],
            :conf_file => node['thumbor_ng']['conf_file'],
            :key_file => node['thumbor_ng']['key_file'],
            :listen_address => node['thumbor_ng']['listen_address']
           )
  only_if { node['thumbor_ng']['init_style'] == 'upstart' }
end

# thumbor init.d configuration file
template '/etc/init.d/thumbor' do
  source 'thumbor.init.erb'
  owner 'root'
  group 'root'
  mode '0755'
  notifies :restart, 'service[thumbor]', :delayed if node['thumbor_ng']['notify_restart']
  only_if { node['thumbor_ng']['init_style'] == 'initd' }
end

# thumbor key file
file '/etc/thumbor.key' do
  content node['thumbor_ng']['key']
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[thumbor]', :delayed if node['thumbor_ng']['notify_restart']
end

# thumbor configuration file
template '/etc/thumbor.conf' do
  source 'thumbor.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[thumbor]', :delayed if node['thumbor_ng']['notify_restart']
  variables(:options => node['thumbor_ng']['options'])
end

# thumbor service
service 'thumbor' do
  case node['thumbor_ng']['init_style']
  when 'upstart'
    provider Chef::Provider::Service::Upstart
  else
    provider Chef::Provider::Service::Init
  end
  supports :restart => true, :start => true, :stop => true, :reload => true, :status => true
  service_name node['thumbor_ng']['service_name']
  action [:enable, :start]
end
