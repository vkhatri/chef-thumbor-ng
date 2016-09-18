name 'thumbor_ng'
maintainer 'Virender Khatri'
maintainer_email 'vir.khatri@gmail.com'
license 'Apache 2.0'
description 'Installs/Configures Thumbor'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.4.2'

source_url 'https://github.com/vkhatri/chef-thumbor-ng' if respond_to?(:source_url)
issues_url 'https://github.com/vkhatri/chef-thumbor-ng/issues' if respond_to?(:issues_url)

depends 'apt'
depends 'python'
depends 'nginx'
depends 'ulimit'
depends 'monit-ng'
depends 'cron', '>= 1.2.0'

supports 'ubuntu'
