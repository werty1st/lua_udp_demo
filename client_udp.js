var PORT = 3004;
var HOST = 'localhost';

var dgram = require('dgram');
var client = dgram.createSocket('udp4');

var data = {"User-Agent": "nodejs/7.0","eventType": "play","start": "2017-05-12T11:57:55+02:00","asset": "SCMS_98920390-08d1-42aa-a7d2-051f5d76c85f","user": "d4905952d4b73ac577261a3ddf7f83f2"};
var message = new Buffer(JSON.stringify(data));



client.on('message', function(message, remote){
	console.log("Received from server: " + message);
	client.close();
});


client.send(message, 0, message.length, PORT, HOST, function(err, bytes) {
    if (err) throw err;
    console.log('UDP message sent to ' + HOST +':'+ PORT);
    //client.close();
});
