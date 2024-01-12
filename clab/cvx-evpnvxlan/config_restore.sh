#!/bin/bash

targets_cvx=(s1 s2 l1 l2 l3 l4)

for t in ${targets_cvx[@]}; do
	echo "restore $t"
        docker cp bkup_configs/$t/interfaces clab-ip_fabric_lab-$t:/etc/network/interfaces
	docker exec -it clab-ip_fabric_lab-$t systemctl reload networking.service
        docker cp bkup_configs/$t/daemons clab-ip_fabric_lab-$t:/etc/frr/daemons
        docker cp bkup_configs/$t/frr.conf clab-ip_fabric_lab-$t:/etc/frr/frr.conf
	docker exec -it clab-ip_fabric_lab-$t systemctl restart frr.service
done


#docker exec -it clab-ip_fabric_lab-sv11 ip addr add 172.31.0.11/32 dev lo
#docker exec -it clab-ip_fabric_lab-sv21 ip addr add 172.31.0.21/32 dev lo

targets_frr=(sv11 sv21)

for t in ${targets_frr[@]}; do
        echo "restore $t"
        docker cp bkup_configs/$t/frr.conf clab-ip_fabric_lab-$t:/etc/frr/frr.conf
	pid=$(docker exec -it clab-ip_fabric_lab-$t cat /var/run/frr/bgpd.pid | sed -e "s/[\r\n]\+//g")
        docker exec -it clab-ip_fabric_lab-$t kill -9 $pid
        docker exec -it clab-ip_fabric_lab-$t sysctl -w net.ipv4.fib_multipath_hash_policy=1
done
