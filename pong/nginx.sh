#!/bin/bash -x

d=$(readlink -f $(dirname $0))

sudo /usr/local/nginx/sbin/nginx -c $d/nginx.conf &
nx=$!

httperf --hog --server=localhost --port=3000 --uri=/ --rate=1000 --num-conns=200 --num-calls=100 --burst-length=20 > results/nginx
sudo kill $nx
