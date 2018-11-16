name 'devopsdance-consul-template'
maintainer 'DevopsDance'
maintainer_email 'team@devops.dance'
license 'Apache-2.0'
description 'Installs and configures consul-template daemon'
version '1.1.0'
source_url 'https://github.com/DevopsDance/chef-cookbook-consul-template'
issues_url 'https://github.com/DevopsDance/chef-cookbook-consul-template/issues'

chef_version '~> 12'
chef_version '~> 13'

depends 'ubuntu'
depends 'apt'
depends 'chef-sugar'
depends 'ark'

supports 'ubuntu', '>= 15.04'
supports 'debian', '>= 8.0'
