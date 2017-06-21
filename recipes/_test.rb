include_recipe 'devopsdance-consul-template::default' # ~FC007

consul_template_config '_test' do
  templates [{
    source: ::File.join(node['devopsdance-consul-template']['config_dir'], '_test.conf.ctmpl'),
    destination: '/tmp/example.conf',
    command: '/bin/true',
  }]
  action :create
end
