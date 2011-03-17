rm -rf results
mkdir -p results

./snap.sh $*
./warp.sh $*
./happstack.sh $*
./php.sh
./tornado.sh
./node.sh
./goliath.sh
