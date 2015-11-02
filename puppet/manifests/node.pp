include vagrant
include unix_base
include docker
include stdlib

class { '::consul':
  version => '0.5.2',
  require => Class['unix_base', 'vagrant'],
  config_hash     => {
    'data_dir'    => '/opt/consul',
    'datacenter'  => 'vagrant',
    'log_level'   => 'INFO',
    'client_addr' => $::ipaddress_eth1,
    'bind_addr'   => $::ipaddress_eth1,
    'node_name'   => $::hostname,
    'retry_join'  => ['172.16.3.101'],
  }
}

class { '::nomadproject':
  require        => Class['unix_base'],
  server_list    => ['172.16.3.101'],
  config_hash    => {
    'log_level'  => 'DEBUG',
    'region'     => 'vagrant',
    'datacenter' => 'vagrant1',
  }
}


consul::service { 'data_node':
  port => 2112,
  tags => ['prod']
}

