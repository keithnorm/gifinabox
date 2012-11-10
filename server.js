var express = require('express'),
    app = express();

app.get('/', function(req, res){
    res.send('Call Keith, Reinhart.');
});

var server = app.listen(3000);