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

# if there are errors you may have to run the following again
vagrant provision 

```

running
-------

An example job is added to the nomad master

```
vagrant ssh nomaster
export NOMAD_ADDR="http://`facter ipaddress_eth1`:4646"

cd /vagrant/NomadJobs
nomad run tabinin

# to view the job status run
# it make up to 3 minutes or so to download the Docker image and start it
nomad status tabinin

nomad run <jobName>

```
And any other jobs you feel like

Edit your /etc/hosts file

```
127.0.0.1 tabinin.local
```

Then in your browser  [http://tabinin.local:3000/](http://tabinin.local:3000/) to view the jobs running on your cluster
or to view the running services
[http://localhost:8500/](http://localhost:8500/) in Consul



To view your HAProxy status
[http://localhost:2112/](http://localhost:2112) with the stats/stats2 credentials
