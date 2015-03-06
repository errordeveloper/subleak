In one shell:
```
vagrant up core-01
vagrant ssh core-01 -c 'sudo ip netns exec nsA /home/core/mcreceive 224.2.2.4 5050'
```

And in another:
```
vagrant ssh core-01 -c 'echo $RANDOM | sudo ip netns exec nsC /home/core/mcsend 224.2.2.4 5050'
vagrant ssh core-01 -c 'echo $RANDOM | sudo ip netns exec nsB /home/core/mcsend 224.2.2.4 5050'
vagrant ssh core-01 -c 'echo $RANDOM | sudo ip netns exec nsC /home/core/mcsend 224.2.2.4 5050'
```
