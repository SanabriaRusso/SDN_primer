#!/bin/sh
echo '--->Create the switch'
sudo ovs-vsctl add-br br0
sudo ovs-vsctl set-controller br0 tcp:10.1.2.202 # replace IP if you want other location
sudo ovs-vsctl set-fail-mode br0 standalone # standalone is normal switch, secure is SDN-controlled
sudo ovs-vsctl set Brdige br0 protocols=OpenFlow13

echo '--->Setting the interfaces'
# all interfaces controlled by OVS must have the same MAC address.
# the only IP address is assigned to the OVS itself. Just as with real switches
sudo ifconfig eth0 down
sudo ifconfig eth0 hw ether 00:00:00:00:00:01 # changing the MAC address
sudo ifconfig eth0 0 up # erase IP address of interface and bring it up

# below is an example of adding another interface
# sudo ifconfig eth2 down
# sudo ifconfig eth2 hw ether 00:00:00:00:00:01
# sudo ifconfig eth2 0 up

echo '--->Attach interface to OVS'
sudo ovs-vsctl add-port br0 eth0

echo '--->Configuring OVS logical interface'
sudo ifconfig br0 hw ether 00:00:00:00:00:01 # remember, all interfaces must have the same MAC
sudo ifconfig br0 172.24.1.5 netmask 255.255.255.0 up # change the IP for the other OVS

echo '--->Setting routes'
sudo ip route add 172.24.1.0/24 dev br0 > /dev/null

echo '--->Making sure interfaces are up'
sudo ifconfig br0 up
sudo ifconfig eth0 up

echo '--->Kill dhcp daemon'
sudo pkill dhcp*

echo '---> Blackholing ICMP port unreachable messages'
sudo iptables -I OUTPUT -p icmp --icmp-type destination-unreachable -j DROP
