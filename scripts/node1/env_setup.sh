#!/bin/bash

function env_setup {
	export nodes="/root/scripts/nodes"

	yum -y install wget httpd createrepo
	/etc/init.d/httpd start

	/etc/init.d/iptables stop 2> /dev/null > /dev/null

	~/scripts/known_hosts.sh
	cp ~/scripts/ambari.repo /etc/yum.repos.d/
	~/scripts/distFile.sh /etc/yum.repos.d/ambari.repo /etc/yum.repos.d

	for cur_node in `cat ${nodes}`; do
		ssh -o StrictHostKeyChecking=no -f $cur_node "echo 'export JAVA_HOME=/usr/jdk64/jdk1.8.0_40' >> ~/.bash_profile"
		ssh -o StrictHostKeyChecking=no -f $cur_node "echo 'PATH=$PATH:$JAVA_HOME/bin' >> ~/.bash_profile"
	done
}
env_setup

exit

