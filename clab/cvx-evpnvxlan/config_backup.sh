#!/bin/bash

targets_cvx=(s1 s2 l1 l2 l3 l4)

for t in ${targets_cvx[@]}; do
	echo "backup $t"
        docker cp clab-ip_fabric_lab-$t:/etc/network/interfaces bkup_configs/$t/
        docker cp clab-ip_fabric_lab-$t:/etc/frr/daemons bkup_configs/$t/
        docker cp clab-ip_fabric_lab-$t:/etc/frr/frr.conf bkup_configs/$t/
done


targets_frr=(sv11 sv21)

for t in ${targets_frr[@]}; do
	echo "backup $t"
        docker cp clab-ip_fabric_lab-$t:/etc/frr/daemons bkup_configs/$t/
        docker cp clab-ip_fabric_lab-$t:/etc/frr/frr.conf bkup_configs/$t/
done
