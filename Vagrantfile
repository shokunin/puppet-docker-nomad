VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.provision "shell",
    inline: "sudo apt-get -y install puppet"

  config.vm.define "nomaster" do |server|
    server.vm.box = "ubuntu/xenial64"
    server.vm.host_name = 'nomaster'
    server.vm.network "forwarded_port", guest: 8500, host: 8500
    server.vm.network "forwarded_port", guest: 2378, host: 2378
    server.vm.network "forwarded_port", guest: 3000, host: 3000
    server.vm.network "forwarded_port", guest: 4647, host: 4647
    server.vm.network "forwarded_port", guest: 4646, host: 4646
    server.vm.network "forwarded_port", guest: 2112, host: 2112
    server.vm.network "private_network", ip: "172.16.3.101"
    server.vm.synced_folder "puppet/modules", "/tmp/vagrant-puppet/puppet/modules"
    server.vm.provision :puppet do |puppet|
      puppet.hiera_config_path = "puppet/ext/hiera.yaml"
      puppet.manifests_path = "puppet/manifests"
      puppet.options = ["--modulepath", "/tmp/vagrant-puppet/puppet/modules", "--parser", "future"]
      puppet.manifest_file = "nomaster.pp"
    end
  end #server

  config.vm.define "node1" do |node|
    node.vm.box = "ubuntu/xenial64"
    node.vm.host_name = 'node1'
    node.vm.network "private_network", ip: "172.16.3.102"
    node.vm.synced_folder "puppet/modules", "/tmp/vagrant-puppet/puppet/modules"
    node.vm.provision :puppet do |puppet|
      puppet.hiera_config_path = "puppet/ext/hiera.yaml"
      puppet.manifests_path = "puppet/manifests"
      puppet.options = ["--modulepath", "/tmp/vagrant-puppet/puppet/modules", "--parser", "future"]
      puppet.manifest_file = "node.pp"
    end
  end #node

  config.vm.define "node2" do |node|
    node.vm.box = "ubuntu/xenial64"
    node.vm.host_name = 'node2'
    node.vm.network "private_network", ip: "172.16.3.103"
    node.vm.synced_folder "puppet/modules", "/tmp/vagrant-puppet/puppet/modules"
    node.vm.provision :puppet do |puppet|
      puppet.hiera_config_path = "puppet/ext/hiera.yaml"
      puppet.manifests_path = "puppet/manifests"
      puppet.options = ["--modulepath", "/tmp/vagrant-puppet/puppet/modules", "--parser", "future"]
      puppet.manifest_file = "node.pp"
    end
  end #node

end
