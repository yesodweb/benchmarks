#!/bin/bash -x

d=$(readlink -f $(dirname $0))

php-fpm -n

/usr/local/nginx/sbin/nginx -c $d/php.nginx.conf &
nx=$!

httperf --hog --server=localhost --port=3000 --uri=/ --rate=1000 --num-conns=200 --num-calls=100 --burst-length=20 > results/php
kill $nx

killall -KILL php-fpm
