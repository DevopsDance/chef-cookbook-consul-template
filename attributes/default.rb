default['devopsdance-consul-template'].tap do |consul_template|
  consul_template['version'] = '0.19.5'
  consul_template['config_dir'] = '/etc/consul-template.d'
  consul_template['config_template_dir'] = '/etc/consul-templates'
  consul_template['config'] = {}
  consul_template['extra_params'] = '-vault-renew-token=false -log-level=debug'
end
