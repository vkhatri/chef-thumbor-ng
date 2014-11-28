#
# Cookbook Name:: thumbor_ng
# Recipe:: default
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

# setup python
include_recipe 'python'

# setup thumbor service user
include_recipe 'thumbor_ng::user'

# install thumbor packages
include_recipe 'thumbor_ng::install'

# thumbor frontend proxy
case node['thumbor_ng']['proxy']
when 'nginx'
  include_recipe 'thumbor_ng::nginx'
when 'haproxy'
  # Experimental, not yet developed
  include_recipe 'thumbor_ng::haproxy'
else
  include_recipe 'thumbor_ng::nginx'
end

# setup redis
include_recipe 'thumbor_ng::redis'

# thumbor configuration
include_recipe 'thumbor_ng::config'

# setup monit
include_recipe 'thumbor_ng::monit' if node['thumbor_ng']['monit']['enable']

# setup cron
include_recipe 'thumbor_ng::cron'