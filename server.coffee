express = require('express')
app = express()

app.get '/', (req, res) ->
    res.send('Call Coffee, Reinhart.')

server = app.listen(3000)
