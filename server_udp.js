var PORT = 3004;
var HOST = '127.0.0.1';

var dgram = require('dgram');
var server = dgram.createSocket('udp4');

server.on('listening', function () {
    var address = server.address();
    console.log('UDP Server listening on ' + address.address + ":" + address.port);
});

server.on('message', function (message, remote) {
    console.log(remote.address + ':' + remote.port +' - ' + message);

    //answer
    server.send("pong", remote.port, remote.address, (d) => { /*console.log("sent pong to client")*/ });
});

server.bind(PORT, HOST);

//start ab -n 10000 -c 100 https://sofa.zdf.de/lua
