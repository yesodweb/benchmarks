#!/bin/bash -x
DIR="$( cd "$( dirname "$0" )" && pwd )"
d=$(readlink -f $DIR)
source lib.sh

java -jar winstone-0.9.10.jar --warfile pong.war  --httpPort=3000 &

benchmark
