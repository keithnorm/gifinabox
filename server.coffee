express = require('express')
app = express()

app.get '/', (req, res) ->
    res.send('Call Keith, Reinhart.')

server = app.listen(3000)
