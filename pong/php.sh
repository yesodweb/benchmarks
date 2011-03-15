#!/bin/bash -x
DIR="$( cd "$( dirname "$0" )" && pwd )"
d=$(readlink -f $DIR)
source lib.sh

php-fpm -n

sudo /usr/local/nginx/sbin/nginx -c $d/php.nginx.conf &

benchmark

killall -KILL php-fpm
