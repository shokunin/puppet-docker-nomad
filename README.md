puppet-docker-swarm
===================

Spin up a Docker swarm host and two nodes to run stuff on


setup
-----

```
git clone https://github.com/shokunin/puppet-docker-swarm.git

# requires ruby bunder installed
bundle install

# download the puppet modules
cd puppet
r10k puppetfile install

# startup
cd ..
vagrant up

```

using
-----

on localhost determine that everyone is running

```
$ sudo docker -H tcp://localhost:2378 info
Containers: 7
Strategy: spread
Filters: affinity, health, constraint, port, dependency
Nodes: 2
 node1: 172.16.3.102:2375
  └ Containers: 5
  └ Reserved CPUs: 0 / 1
  └ Reserved Memory: 0 B / 514.5 MiB
 node2: 172.16.3.103:2375
  └ Containers: 2
  └ Reserved CPUs: 0 / 1
  └ Reserved Memory: 0 B / 514.5 MiB
```

spin up a redis container

```
$ sudo docker -H tcp://localhost:2378 run --name test-redis -d redis
```

see it running

```
$ sudo docker -H tcp://localhost:2378 ps
CONTAINER ID        IMAGE               COMMAND                CREATED             STATUS              PORTS               NAMES
67f550d51d45        redis:latest        "/entrypoint.sh redi   10 minutes ago      Up 9 minutes        6379/tcp            node2/test-redis    
```




