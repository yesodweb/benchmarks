mkdir -p results

./snap.sh $*
./warp.sh $*
./happstack.sh $*
./php.sh
./tornado.sh
./node.sh
#./nginx.sh
./goliath.sh
