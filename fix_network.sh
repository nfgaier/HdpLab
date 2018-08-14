apt-get install bridge-utils

service docker stop
ip link set dev docker0 down
brctl delbr docker0

brctl addbr docker0
ip addr add 172.17.42.1/16 dev docker0
ip link set dev docker0 up

service docker start

ifconfig docker0 | grep "inet addr"

