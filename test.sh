#!/bin/sh
set -e -x

ip link add brm type bridge
ip link set brm up

function make_ns () {
    x=$1
    ip=$2
    ip netns add ns${x}
    ip netns exec ns${x} ip link set lo up
    ip link add int${x} type veth peer name ext${x}
    ip link set int${x} up netns ns${x}
    ip link set ext${x} up master brm
    ip netns exec ns${x} ip addr add $ip dev int${x}
    ip netns exec ns${x} ip route add 224.0.0.0/8 dev int${x}
}

make_ns A 10.20.1.1/24
make_ns B 10.20.1.2/24
make_ns C 10.20.2.1/24
