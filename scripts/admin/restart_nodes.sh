#!/bin/sh
docker stop node1 node2 node3 node4 node5
docker start node1
docker start node2 
docker start node3
docker start node4
docker start node5
