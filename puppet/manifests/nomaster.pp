include vagrant
include unix_base
include stdlib 
include docker 
include nomadproject 

hiera_include('classes', [])

class { '::consul':
  version              => '0.5.2',
  require => Class['unix_base', 'vagrant'],
  config_hash          => {
    'bootstrap_expect' => 1,
    'client_addr'      => '0.0.0.0',
    'data_dir'         => '/opt/consul',
    'datacenter'       => 'vagrant',
    'log_level'        => 'INFO',
    'node_name'        => $::hostname,
    'server'           => true,
    'ui_dir'           => '/opt/consul/ui',
  }

}
