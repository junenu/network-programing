```
junenu@lucifer:~/network-programing/clab/ceos01$ sudo clab deploy -t ceos01.clab.yml 
[sudo] password for junenu: 
INFO[0000] Containerlab v0.49.0 started                 
INFO[0000] Parsing & checking topology file: ceos01.clab.yml 
INFO[0000] Creating docker network: Name="clab", IPv4Subnet="172.20.20.0/24", IPv6Subnet="2001:172:20:20::/64", MTU='ל' 
INFO[0000] Creating lab directory: /home/junenu/network-programing/clab/ceos01/clab-ceos 
INFO[0000] Creating container: "ceos2"                  
INFO[0000] Creating container: "ceos1"                  
INFO[0001] Creating link: ceos1:eth1 <--> ceos2:eth1    
INFO[0001] Running postdeploy actions for Arista cEOS 'ceos2' node 
INFO[0001] Running postdeploy actions for Arista cEOS 'ceos1' node 
INFO[0052] Adding containerlab host entries to /etc/hosts file 
INFO[0052] Adding ssh config for containerlab nodes     
+---+-----------------+--------------+--------------+------+---------+----------------+----------------------+
| # |      Name       | Container ID |    Image     | Kind |  State  |  IPv4 Address  |     IPv6 Address     |
+---+-----------------+--------------+--------------+------+---------+----------------+----------------------+
| 1 | clab-ceos-ceos1 | cdc19f1f9ef4 | ceos:4.30.4M | ceos | running | 172.20.20.3/24 | 2001:172:20:20::3/64 |
| 2 | clab-ceos-ceos2 | 8e7f01802ec6 | ceos:4.30.4M | ceos | running | 172.20.20.2/24 | 2001:172:20:20::2/64 |
+---+-----------------+--------------+--------------+------+---------+----------------+----------------------+
```