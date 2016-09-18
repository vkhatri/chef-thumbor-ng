#
# Cookbook Name:: thumbor_ng
# Recipe:: nginx
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

include_recipe 'nginx'

# may require different logrotate for different init_style
template '/etc/logrotate.d/nginx' do
  owner 'root'
  group 'root'
  mode 0o644
  source 'nginx.logrotate.erb'
  variables(:log_dir => node['nginx']['log_dir'],
            :user => node['nginx']['user'],
            :group => node['nginx']['group'],
            :size => node['thumbor_ng']['logrotate']['size'],
            :rotate => node['thumbor_ng']['logrotate']['rotate'])
end

config_file = case node['platform_family']
              when 'rhel'
                '/etc/sysconfig/nginx'
              when 'debian'
                '/etc/default/nginx'
              end

template config_file do
  source 'nginx.service.config.erb'
  owner node['nginx']['user']
  group node['nginx']['group']
  mode '0644'
  notifies :restart, 'service[nginx]', :delayed if node['thumbor_ng']['notify_restart']
  variables(:filehandle_limit => node['thumbor_ng']['limits']['nofile'])
end

# nginx proxy cache location
directory node['thumbor_ng']['nginx']['proxy_cache']['path'] do
  owner node['nginx']['user']
  group node['nginx']['group']
  mode '0700'
  action :create
  recursive true
  only_if { node['thumbor_ng']['nginx']['proxy_cache']['enabled'] }
end

# nginx thumbor vhost configuration file
template '/etc/nginx/sites-available/thumbor' do
  cookbook node['thumbor_ng']['nginx']['vhost']['cookbook']
  source node['thumbor_ng']['nginx']['vhost']['template']
  owner node['nginx']['user']
  group node['nginx']['group']
  mode '0644'
  notifies :restart, 'service[nginx]', :delayed if node['thumbor_ng']['notify_restart']
  variables(
    if node['thumbor_ng']['nginx']['vhost']['variables'].empty?
      { :workers => node['thumbor_ng']['workers'],
        :base_port => node['thumbor_ng']['base_port'],
        :listen_address => node['thumbor_ng']['listen_address'],
        :server_port => node['thumbor_ng']['nginx']['port'],
        :server_name => node['thumbor_ng']['nginx']['server_name'],
        :client_max_body_size => node['thumbor_ng']['nginx']['client_max_body_size'],
        :proxy_cache_valid => node['thumbor_ng']['nginx']['proxy_cache_valid'],
        :proxy_read_timeout => node['thumbor_ng']['nginx']['proxy_read_timeout'],
        :proxy_cache_enabled => node['thumbor_ng']['nginx']['proxy_cache']['enabled'],
        :proxy_cache_path => node['thumbor_ng']['nginx']['proxy_cache']['path'],
        :proxy_cache_key_zone => node['thumbor_ng']['nginx']['proxy_cache']['key_zone'],
        :enable_status => node['thumbor_ng']['nginx']['enable_status'] }
    else
      node['thumbor_ng']['nginx']['vhost']['variables']
    end
  )
end

nginx_site 'thumbor' do
  enable true
end
