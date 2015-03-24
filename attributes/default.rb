##### thumbor cookbook core attributes

default['thumbor_ng']['version'] = '4.12.2'
default['thumbor_ng']['workers'] = node['cpu']['total']
default['thumbor_ng']['base_port'] = 9000
default['thumbor_ng']['key'] = 'secretkey'

default['thumbor_ng']['init_style'] = 'upstart' # options: upstart, initd
default['thumbor_ng']['service_name'] = 'thumbor'
default['thumbor_ng']['install_method'] = 'pip'
default['thumbor_ng']['pip_dependencies'] = ['remotecv', 'graphicsmagick-engine', 'opencv-engine']
default['thumbor_ng']['listen_address'] = '127.0.0.1'
default['thumbor_ng']['binary'] = '/usr/local/bin/thumbor'
default['thumbor_ng']['upstart_respawn'] = true

default['thumbor_ng']['conf_file'] = '/etc/thumbor.conf'
default['thumbor_ng']['key_file'] = '/etc/thumbor.key'
default['thumbor_ng']['service_config_file'] = case node['platform_family']
                                               when 'debian'
                                                 '/etc/default/thumbor'
                                               when 'rhel'
                                                 '/etc/sysconfig/thumbor'
                                               end

default['thumbor_ng']['proxy'] = 'nginx' # options: nginx

# notify restart to service
default['thumbor_ng']['notify_restart'] = true

# thumbor workers log location
default['thumbor_ng']['log_dir'] = '/var/log/thumbor'

# thumbor log level
default['thumbor_ng']['log_level'] = 'warning'

# thumbor logrotate
default['thumbor_ng']['logrotate']['rotate'] = 7

# thumbor service user
default['thumbor_ng']['setup_user']  = true
default['thumbor_ng']['group'] = 'thumbor'
default['thumbor_ng']['user'] = 'thumbor'
default['thumbor_ng']['user_home'] = nil

# thumbor process limits
default['thumbor_ng']['limits']['memlock'] = 'unlimited'
default['thumbor_ng']['limits']['nofile'] = 48_000
default['thumbor_ng']['limits']['nproc'] = 'unlimited'

##### thumbor configuration options
# https://github.com/thumbor/thumbor/wiki/Configuration
# For default parameters value, check out thumbor-config command

# thumbor storage location
default['thumbor_ng']['options']['FILE_STORAGE_ROOT_PATH'] = '/var/lib/thumbor/storage'
default['thumbor_ng']['options']['RESULT_STORAGE_FILE_STORAGE_ROOT_PATH'] = '/var/lib/thumbor/result-storage'

##### monit
default['thumbor_ng']['monit']['enable'] = false

##### nginx
# keeping nginx configuration minimal.
# modify attributes for cookbook nginx as per requirement

# disable nginx default vhost
node.default['nginx']['default_site_enabled'] = false
node.default['nginx']['worker_connections'] = '4096'

# nginx thumbor vhost configuration
default['thumbor_ng']['nginx']['port'] = 80
default['thumbor_ng']['nginx']['server_name'] = node['fqdn']
default['thumbor_ng']['nginx']['client_max_body_size'] = '10M'
default['thumbor_ng']['nginx']['proxy_read_timeout'] = '300'
default['thumbor_ng']['nginx']['proxy_cache']['enabled'] = false
default['thumbor_ng']['nginx']['proxy_cache']['path'] = '/var/www/thumbor_cache'
default['thumbor_ng']['nginx']['proxy_cache']['key_zone'] = 'thumbor_cache'
default['thumbor_ng']['nginx']['proxy_cache_valid'] = '900s'
default['thumbor_ng']['nginx']['vhost']['cookbook'] = 'thumbor_ng'
default['thumbor_ng']['nginx']['vhost']['template'] = 'nginx.vhost.erb'
default['thumbor_ng']['nginx']['vhost']['variables'] = {}

##### redisio
# keeping redis configuration minimal.
# modify attributes for cookbook redisio as per requirement

# setup local redis server
default['thumbor_ng']['setup_redis']  = false

node.default['redisio']['version'] = '2.8.17'
