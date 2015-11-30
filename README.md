puppet-docker-nomad
===================

Spin up a Docker nomad host and two nodes to run stuff on


setup
-----

```
git clone https://github.com/shokunin/puppet-docker-nomad

# requires ruby bunder installed
bundle install

# download the puppet modules
cd puppet
r10k puppetfile install

# startup
cd ..
vagrant up

```

running
-------

An example job is added to the nomad master

```
export NOMAD_ADDR="http://`facter ipaddress_eth1`:4646"
nomad run /etc/example_job.nomad 
nomad status
nomad status nomad-example

```

