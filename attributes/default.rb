default['devopsdance-consul-template'].tap do |consul_template|
  consul_template['version'] = '0.18.5'
  consul_template['config_dir'] = '/etc/consul-template.d'
  consul_template['config_template_dir'] = '/etc/consul-templates'
  consul_template['service_user'] = 'root'
  consul_template['service_group'] = 'root'
  consul_template['config'] = {}
end
