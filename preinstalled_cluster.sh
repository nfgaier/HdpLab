#!/bin/bash

docker stop node1 node2 node3 node4 node5 > /tmp/docker.log
docker rm  node1 node2 node3 node4 node5 > /tmp/docker.log 
echo '' > ~/.ssh/known_hosts

#Start node1, which will be running the ambari-server process
CID_namenode=$(docker run -d --dns 127.0.0.1 --privileged=true -p 8080:8080 -p 8440:8440 -p 8441:8441 -p 50070:50070 -p 50075:50075 -p 8020:8020 -p 1111:22 -e NODE_TYPE=namenode --name node1 -h node1 -i -t hdp/pre-installed-master)
IP_namenode=$(docker inspect --format "{{ .NetworkSettings.IPAddress }}" node1)
echo "node1 started at $IP_namenode"

nodename="node2"
CID=$(docker run -d --dns 127.0.0.1 --privileged=true -h $nodename --name $nodename -p 2222:22 --link node1:node1 -p 8088:8088 -p 11000:11000 -p 19888:19888 -p 8440 -p 8441 -i -t hdp/worker-node)
IP_node=$(docker inspect --format "{{ .NetworkSettings.IPAddress }}" $nodename)
echo "$nodename started at $IP_node"

nodename="node3"
CID=$(docker run -d --dns 127.0.0.1 --privileged=true -h $nodename --name $nodename -p 3333:22 --link node1:node1 -p 8440 -p 8441 -i -t hdp/worker-node)
IP_node=$(docker inspect --format "{{ .NetworkSettings.IPAddress }}" $nodename)
echo "$nodename started at $IP_node"

nodename="node4"
CID=$(docker run -d --dns 127.0.0.1 --privileged=true -h $nodename --name $nodename -p 4444:22 --link node1:node1 -p 8440 -p 8441 -i -t hdp/worker-node)
IP_node=$(docker inspect --format "{{ .NetworkSettings.IPAddress }}" $nodename)
echo "$nodename started at $IP_node"

nodename="node5"
CID=$(docker run -d --dns 127.0.0.1 --privileged=true -h $nodename --name $nodename -p 5555:22 --link node1:node1 -p 8440 -p 8441 -i -t hdp/worker-node)
IP_node=$(docker inspect --format "{{ .NetworkSettings.IPAddress }}" $nodename)
echo "$nodename started at $IP_node"

echo -e "Cluster is ready to use now.\n\n" 
