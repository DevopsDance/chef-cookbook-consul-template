resource_name :consul_template_config
default_action :create

property :name, kind_of: String, name_attribute: true
property :templates, kind_of: Array, default: []

action :create do
  templates = new_resource.templates.map { |v| Mash.from_hash(v) }

  templates.each_with_index do |v, i|
    raise "Missing source for #{i} entry at '#{new_resource.name}" if v[:source].nil?
    raise "Missing destination for #{i} entry at '#{new_resource.name}" if v[:destination].nil?
  end

  template_path = ::File.join(node['devopsdance-consul-template']['config_dir'],
                              new_resource.name)

  template template_path do
    cookbook 'devopsdance-consul-template'
    source 'config.erb'
    user 'root'
    group node['devopsdance-consul-template']['service_group']
    mode '0640'
    variables templates: templates
    notifies :restart, 'service[consul-template]', :delayed
    action :create
    not_if { templates.empty? }
  end
end

action :delete do
  file_path = ::File.join(node['devopsdance-consul-template']['config_dir'],
                          new_resource.name)

  file file_path do
    notifies :restart, 'service[consul-template]', :delayed
    action :delete
  end
end
