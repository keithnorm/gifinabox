var express = require('express'),
    app = express();

app.get('/', function(req, res){
    res.send('Call Keith, Reinhart.');
});

var server = app.listen(3000);
console.log('Express server started on port %s', server.address().port);

