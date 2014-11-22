name 'thumbor_ng'
maintainer 'Virender Khatri'
maintainer_email 'vir.khatri@gmail.com'
license 'Apache 2.0'
description 'Installs/Configures Thumbor'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.2.3'

depends 'apt'
depends 'python'
depends 'nginx'
depends 'ulimit'
depends 'monit-ng'
depends 'redisio'

supports 'ubuntu'
