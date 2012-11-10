express = require('express')
app = express()

app.get '/', (req, res) ->
  res.render 'index.jade', layout: 'layout.jade'

server = app.listen(3000)
