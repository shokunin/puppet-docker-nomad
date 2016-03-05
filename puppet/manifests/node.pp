
class { '::consul':
  version              => '0.6.3',
  require              => Class['unix_base', 'vagrant', 'ubuntu_pkgs'],
  config_hash          => {
    'bootstrap_expect' => 2,
    'client_addr'      => "0.0.0.0",
    'advertise_addr'   => $::ipaddress_eth1,
    'data_dir'         => '/opt/consul',
    'datacenter'       => 'vagrant',
    'log_level'        => 'INFO',
    'node_name'        => $::hostname,
    'retry_join'       => ['172.16.3.101'],
    'server'           => true,
    'ui_dir'           => '/opt/consul/ui',

  }
}

class { '::nomadproject':
  server_list    => ['172.16.3.101'],
  bind_interface => 'eth1',
  require        => Class['unix_base', 'vagrant', 'ubuntu_pkgs'],
  config_hash    => {
    'log_level'  => 'DEBUG',
    'region'     => 'vagrant',
    'datacenter' => 'vagrant1',
    'bind_addr'  => $::ipaddress_eth1,
  }
}


consul::service { 'data_node':
  port => 2112,
  tags => ['prod']
}

