rm -rf results
mkdir -p results

./snap.sh $*
./warp.sh $*
./happstack.sh $*
./yesod.sh $*
sudo ./php.sh
./tornado.sh
./node.sh
./goliath.sh
./winstone.sh
