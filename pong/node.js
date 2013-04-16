var http = require('http');
var cluster = require('cluster');

if(cluster.isMaster) {
  for(var i = 0; i < 3; i++) {
    cluster.fork();
  }
} else {
  http.createServer(function (req, res) {
    res.writeHead(200, {'Content-Type': 'text/plain'});
    res.end('PONG');
  }).listen(3000, "127.0.0.1");
}
