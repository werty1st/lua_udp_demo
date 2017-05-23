var PORT = 3009;
var HOST = '0.0.0.0';

var dgram = require('dgram');
var server = dgram.createSocket('udp4');

server.on('listening', function () {
    var address = server.address();
    console.log('UDP Server listening on ' + address.address + ":" + address.port);
});

server.on('message', function (message, remote) {
    console.log(remote.address + ':' + remote.port +' - ' + message);

    //answer
    try{
        server.send("pong", remote.port, remote.address, (d) => { /*console.log("sent pong to client")*/ });
    } catch (e){
	//console.error("answering client failed",e);
    }

});

server.bind(PORT, HOST);

//start ab -n 10000 -c 100 https://sofa.zdf.de/lua
