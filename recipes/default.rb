include_recipe 'chef-sugar::default'

if ubuntu?
  include_recipe 'ubuntu'
elsif debian?
  include_recipe 'apt'
else
  raise 'Unsupported platform'
end

include_recipe 'ark::default'

arch = case node['kernel']['machine']
       when 'x86_64'
         'amd64'
       when 'i386'
         'i386'
       else
         raise 'Unsupported CPU architecture'
       end

version = node['devopsdance-consul-template']['version']

ark 'consul-template' do
  url "https://releases.hashicorp.com/consul-template/#{version}/consul-template_#{version}_#{node['os']}_#{arch}.tgz"
  version node['devopsdance-consul-template']['version']
  strip_components 0
  notifies :restart, 'service[consul-template]', :delayed
  action :install
end

directory node['devopsdance-consul-template']['config_dir'] do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

directory node['devopsdance-consul-template']['config_template_dir'] do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

file File.join(node['devopsdance-consul-template']['config_dir'], 'default.json') do
  owner 'root'
  group node['devopsdance-consul-template']['service_group']
  mode '0640'
  content JSON.pretty_generate(node['devopsdance-consul-template']['config'], quirks_mode: true)
  notifies :restart, 'service[consul-template]', :delayed
  action :create
end

systemd_unit 'consul-template.service' do
  content(
    'Unit' => {
      'Description' => 'Consul Template',
      'After' => 'network.target',
    },
    'Install' => {
      'WantedBy' => 'multi-user.target',
    },
    'Service' => {
      'ExecStart' => "#{node['ark']['prefix_home']}/consul-template/consul-template -config #{node['devopsdance-consul-template']['config_dir']}",
      'ExecReload' => '/bin/kill -HUP $MAINPID',
    })
  notifies :restart, 'service[consul-template]', :delayed
  action [
    :create,
    :enable,
  ]
end

service 'consul-template' do
  action :start
end
