ip link add dev vtestA0 type veth peer name vtestA1
ip link add dev vtestB0 type veth peer name vtestB1
ip link add dev vtestC0 type veth peer name vtestC1

ip link set dev vtestA0 up
ip link set dev vtestB0 up
ip link set dev vtestC0 up

ip tuntap add tapm mode tap
ip link set dev tapm up
ip link add brm type bridge

ip link set tapm master brm
ip link set vtestA0 master brm
ip link set vtestB0 master brm
ip link set vtestC0 master brm

#ip addr add 10.0.0.1/24 dev brm

ip link set brm up

ip link set vtestA1 up
ip link set vtestB1 up
ip link set vtestC1 up

ip netns add nsA
ip netns add nsB
ip netns add nsC

ip link set vtestA1 netns nsA 
ip link set vtestB1 netns nsB 
ip link set vtestC1 netns nsC 

ip netns exec nsA ip link set dev lo up
ip netns exec nsB ip link set dev lo up
ip netns exec nsC ip link set dev lo up

ip netns exec nsA ip addr add 10.0.1.2/24 dev vtestA1
ip netns exec nsB ip addr add 10.0.1.4/24 dev vtestB1
ip netns exec nsC ip addr add 10.0.2.2/24 dev vtestC1

iptables -t nat -A POSTROUTING -o brm -j MASQUERADE
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
