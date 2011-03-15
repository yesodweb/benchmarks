#!/bin/bash -x
DIR="$( cd "$( dirname "$0" )" && pwd )"
d=$(readlink -f $DIR)
source lib.sh

mkdir -p passenger/public
mkdir -p passenger/tmp

sudo /opt/nginx/sbin/nginx -c /opt/nginx/conf/nginx.conf

benchmark
