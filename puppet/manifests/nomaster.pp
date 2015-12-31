include vagrant
include unix_base
include stdlib 
include docker 
include ubuntu_pkgs 

hiera_include('classes', [])

class { '::consul':
  version              => '0.5.2',
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

##########################################################################################
#   Setup the haproxy/template pair

apt::source { 'haproxy-ppa':
  location   => 'http://ppa.launchpad.net/vbernat/haproxy-1.5/ubuntu ',
  repos      => 'main',
  key        => 'CFFB779AADC995E4F350A060505D97A41C61B9CD',
  key_server => 'pgp.mit.edu',
}

package { 'haproxy':
  ensure  => present,
  require => Apt::Source['haproxy-ppa'],
}

file { '/etc/default/haproxy':
  ensure  => present,
  owner   => root,
  group   => root,
  mode    => '0644',
  content => "ENABLED=1\n",
}


#file { '/usr/local/bin/consul-template':
#  ensure => present,
#  owner  => root,
#  group  => root,
#  mode   => '0644',
#  source => 'puppet:///consul-template',
#}

#consul-template -consul=localhost:8500  -template "/etc/haproxy/haproxy.ctmpl:/etc/haproxy/haproxy.cfg:service haproxy reload"


