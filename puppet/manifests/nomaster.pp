include consul_haproxy 

hiera_include('classes', [])

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
    'server'           => true,
    'ui_dir'           => '/opt/consul/ui',
  }
}

class { '::nomadproject':
  server_list    => ['172.16.3.101'],
  require        => Class['unix_base', 'vagrant', 'ubuntu_pkgs'],
  nomad_role     => 'server',
  bind_interface => 'eth1',
  config_hash    => {
    'log_level'  => 'DEBUG',
    'region'     => 'vagrant',
    'datacenter' => 'vagrant1',
    'bind_addr'  => $::ipaddress_eth1,
  }
}

