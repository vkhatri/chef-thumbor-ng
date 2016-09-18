
default['thumbor_ng']['apt']['thumbor']['uri'] = 'http://ppa.launchpad.net/thumbor/ppa/ubuntu'
default['thumbor_ng']['apt']['thumbor']['keyserver'] = 'keyserver.ubuntu.com'
default['thumbor_ng']['apt']['thumbor']['components'] = %w(main)
default['thumbor_ng']['apt']['thumbor']['key'] = '68DFB11CCBEC8F27'
default['thumbor_ng']['apt']['thumbor']['deb_src'] = false
default['thumbor_ng']['apt']['thumbor']['action'] = 'add'

default['thumbor_ng']['apt']['multiverse']['uri'] = 'http://archive.ubuntu.com/ubuntu'
default['thumbor_ng']['apt']['multiverse']['distribution'] = node['lsb']['codename']
default['thumbor_ng']['apt']['multiverse']['keyserver'] = 'keyserver.ubuntu.com'
default['thumbor_ng']['apt']['multiverse']['components'] = %w(main multiverse restricted universe)
default['thumbor_ng']['apt']['multiverse']['key'] = '40976EAF437D05B5'
default['thumbor_ng']['apt']['multiverse']['deb_src'] = false
default['thumbor_ng']['apt']['multiverse']['action'] = 'add'

default['thumbor_ng']['apt']['thumbor']['distribution'] = case node['platform_version']
                                                          when '14.04'
                                                            'saucy'
                                                          else
                                                            node['lsb']['codename']
                                                          end
