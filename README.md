thumbor_ng Cookbook
================

[![Cookbook](http://img.shields.io/badge/cookbook-v0.4.0-green.svg)](https://github.com/vkhatri/chef-thumbor-ng) [![Build Status](https://travis-ci.org/vkhatri/chef-thumbor-ng.svg?branch=master)](https://travis-ci.org/vkhatri/chef-thumbor-ng)


This is a [Chef] Cookbook to Install and Configure [Thumbor].

This cookbook was heavily inspired from thumbor cookbook maintained by Zanui.


## Repository

https://github.com/vkhatri/chef-thumbor-ng


## Supported OS

Currently cookbook only supports Ubuntu 12.04 & 14.04.


## Supported Install Methods

This cookbook only supports `pip` based installation. As mentioned in [Thumbor] wiki, new release is
always available via `pip`. Other install methods like `source code` or `package` are not
incorporated in this cookbook.


## Major Changes

### v0.4.0

Redis setup is not within the scope of this cookbook and hence `redisio` cookbook
dependency has been removed.

## Recipes

- `thumbor_ng::default`    - default cookbook run_list recipe

- `thumbor_ng::install`  	- install packages required for thumbor

- `thumbor_ng::user`   		- setup user for thumbor service

- `thumbor_ng::config`		  - setup and mange thumbor configuration

- `thumbor_ng::monit`		  - setup monit checks for nginx/thumbor using cookbook `monit-ng`

- `thumbor_ng::nginx`		  - setup and manage frontend proxy nginx for thumbor using cookbook `nginx`

- <del> `thumbor_ng::haproxy`		- setup and mange fronend proxy haproxy for thumbor, not completed yet </del>

- <del> `thumbor_ng::varnish`		- setup and mange fronend proxy varnish for thumbor, not completed yet </del>

> For run_list use `recipe[thumbor_ng::default]` or `recipe[thumbor_ng]`


## Cookbook Advanced Attributes

 * `default['thumbor_ng']['proxy']` (default: `nginx`): thumbor service front end proxy, currently only supports nginx

 * `default['thumbor_ng']['storage']['type']` (default: `file`): thumbor storage type

 * `default['thumbor_ng']['init_style']` (default: `upstart`): thumbor service manager, options: initd upstart

 * `default['thumbor_ng']['notify_restart']` (default: `true`): notify thumbor service on a resource change

 * `default['thumbor_ng']['setup_user']` (default: `true`): setup user for thumbor service

 * `default['thumbor_ng']['monit']['enable']` (default: `false`): enables monit checks for nginx and thumbor service using cookbook - `monit-ng`

 * <del> `default['thumbor_ng']['queue']['type']` (default: `redis`): thumbor detector queue type, option complete setup not tested yet </del>



## Cookbook Core Attributes

 * `default['thumbor_ng']['version']` (default: `5.0.6`): [Thumbor] release version

 * `default['thumbor_ng']['processes']` (default: `node['cpu']['total']`): # of thumbor processes, default utilizes all CPU cores

 * `default['thumbor_ng']['base_port']` (default: `9000`): thumbor service base port to spawn multiple processes

 * `default['thumbor_ng']['key']` (default: ``): thumbor secret key file content

 * <del> `default['thumbor_ng']['log_dir']` (default: `/var/log/thumbor`): thumbor logs directory, not yet tested </del>

 * `default['thumbor_ng']['service_name']` (default: `thumbor`): thumbor service name

 * `default['thumbor_ng']['install_method']` (default: `pip`): thumbor install method

 * `default['thumbor_ng']['listen_address']` (default: `127.0.0.1`): inet for thumbor service, change it with caution

 * `default['thumbor_ng']['binary']` (default: `/usr/local/bin/thumbor`): thumbor binary location for thumbor service

 * `default['thumbor_ng']['upstart_respawn']` (default: `true`): respawn service if goes down

 * `default['thumbor_ng']['conf_file']` (default: `/etc/thumbor.conf`): thumbor configuration file

 * `default['thumbor_ng']['key_file']` (default: `/etc/thumbor.key`): thumbor key file

 * `default['thumbor_ng']['group']` (default: `thumbor`): thumbor service group

 * `default['thumbor_ng']['user']` (default: `thumbor`): thumbor service user

 * `default['thumbor_ng']['user_home']` (default: `nil`): thumbor service user home directory

 * `default['thumbor_ng']['pip_dependencies']` (default: `['remotecv', 'graphicsmagick-engine', 'opencv-engine']`): thumbor pip dependencies, user may add custom pip packages

## Cookbook apt Repositories Attributes

 * `default['thumbor_ng']['apt']['thumbor']['uri']` (default: `http://ppa.launchpad.net/thumbor/ppa/ubuntu`): repo uri

 * `default['thumbor_ng']['apt']['thumbor']['distribution']` (default: `node['lsb']['codename']`): repo distribution

 * `default['thumbor_ng']['apt']['thumbor']['keyserver']` (default: `keyserver.ubuntu.com`): repo keyserver

 * `default['thumbor_ng']['apt']['thumbor']['components']` (default: `[main]`): repo components

 * `default['thumbor_ng']['apt']['thumbor']['key']` (default: `68DFB11CCBEC8F27`): repo key

 * `default['thumbor_ng']['apt']['thumbor']['deb_src']` (default: `false`): whether to fetch source

 * `default['thumbor_ng']['apt']['thumbor']['action']` (default: `add`): apt_repository resource action

 * `default['thumbor_ng']['apt']['multiverse']['uri']` (default: `http://archive.ubuntu.com/ubuntu`): repo uri

 * `default['thumbor_ng']['apt']['multiverse']['distribution']` (default: `node['lsb']['codename']`): repo distribution

 * `default['thumbor_ng']['apt']['multiverse']['keyserver']` (default: `keyserver.ubuntu.com`): repo keyserver

 * `default['thumbor_ng']['apt']['multiverse']['components']` (default: `[main multiverse restricted universe]`): repo components

 * `default['thumbor_ng']['apt']['multiverse']['key']` (default: `40976EAF437D05B5`): repo key

 * `default['thumbor_ng']['apt']['multiverse']['deb_src']` (default: `false`): whether to fetch source

 * `default['thumbor_ng']['apt']['multiverse']['action']` (default: `add`): apt_repository resource action


## Cookbook thumbor Service Ulimit Attributes

 * `default['thumbor_ng']['limits']['memlock']` (default: `unlimited`): thumbor service memory limit

 * `default['thumbor_ng']['limits']['nofile']` (default: `48000`): thumbor service file limit

 * `default['thumbor_ng']['limits']['nproc']` (default: `unlimited`): thumbor service proc limit


## Cookbook nginx Attributes

 * `default['nginx']['default_site_enabled']` (default: `false`): disable default nginx site

 * `default['nginx']['worker_connections']` (default: `4096`): nginx worker connections

 * `default['thumbor_ng']['nginx']['port']` (default: `80`): nginx port

 * `default['thumbor_ng']['nginx']['server_name']` (default: `node['fqdn']`): nginx thumbor vhost server name

 * `default['thumbor_ng']['nginx']['client_max_body_size']` (default: `10M`): nginx thumbor vhost client max body

 * `default['thumbor_ng']['nginx']['proxy_read_timeout']` (default: `300`): nginx thumbor vhost proxy read timeout

 * `default['thumbor_ng']['nginx']['proxy_cache']['enabled']` (default: `false`): enable proxy cache in nginx thumbor vhost

 * `default['thumbor_ng']['nginx']['proxy_cache']['path']` (default: `/var/www/thumbor_cache`): nginx thumbor vhost proxy cache location

 * `default['thumbor_ng']['nginx']['proxy_cache']['key_zone']` (default: `thumbor_cache`): nginx thumbor vhost proxy cache key zone

 * `default['thumbor_ng']['nginx']['vhost']['cookbook']` (default: `thumbor_ng`): nginx thumbor vhost template cookbook name

 * `default['thumbor_ng']['nginx']['vhost']['template']` (default: `nginx.thumbor.vhost.erb`): nginx thumbor vhost template name

 * `default['thumbor_ng']['nginx']['vhost']['variables']` (default: `{}`): nginx thumbor vhost template variables

        For more nginx attributes, check out nginx cookbook


## Cookbook monit Attributes

Monit checks for `thumbor` and `nginx` (or `haproxy` or `varnish`).

        For more monit checks attributes & configuration, check out monit-ng cookbook


## Cookbook thumbor Default Configuration Attributes

 * `default['thumbor_ng']['options']['FILE_STORAGE_ROOT_PATH']` (default: `/var/lib/thumbor/file_storage`): thumbor file storage location

 * `default['thumbor_ng']['options']['RESULT_STORAGE_FILE_STORAGE_ROOT_PATH']` (default: `/var/lib/thumbor/result_storage`): thumbor result file storage location


## Cookbook Dependencies

* `apt`
* `python`
* `nginx`
* `ulimit`
* `monit-ng`


## TODO

* Add support for RHEL platform family
* Add HAProxy frontend proxy
* Add Varnish frontend proxy


## Contributing

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests (`rake`), ensuring they all pass
6. Write new resource/attribute description to `README.md`
7. Write description about changes to PR
8. Submit a Pull Request using Github


## Copyright & License

Authors:: Virender Khatri and [Contributors]

<pre>
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
</pre>

[Thumbor]:https://github.com/thumbor/thumbor
[Chef]: https://www.getchef.com/chef/
[Contributors]: https://github.com/vkhatri/chef-thumbor-ng/graphs/contributors
