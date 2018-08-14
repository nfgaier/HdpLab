#!/bin/sh

export nodes="/root/scripts/nodes"

for cur_node in `cat ${nodes}`; do
        echo "============="
        echo "Adding $cur_node to known host list"
        echo "============="
        ssh -o StrictHostKeyChecking=no root@$cur_node echo '' 2>&1 >> /dev/null
done

exit
