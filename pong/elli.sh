#!/bin/bash -x
DIR="$( cd "$( dirname "$0" )" && pwd )"
d=$(readlink -f $DIR)
source lib.sh

./erlang/rel/elli_pong/bin/elli_pong start
/bin/sleep 600 & # just to give the benchmark function s/th to kill later

benchmark

./erlang/rel/elli_pong/bin/elli_pong stop
