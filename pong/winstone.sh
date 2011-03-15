#!/bin/bash -x

d=$(readlink -f $(dirname $0))

java -jar winstone-0.9.10.jar --warfile pong.war  --httpPort=3000 &
ja=$!

sleep 1

httperf --hog --server=localhost --port=3000 --uri=/ --rate=1000 --num-conns=200 --num-calls=100 --burst-length=20 > results/winstone

kill $ja
