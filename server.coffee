express = require('express')
app = express()

mongoose = require('mongoose')
mongoose.connect('mongodb://nodejitsu_nko3-just-name-it-beansna:22s0te0hc7ubqoimcjcnc17071@ds039267.mongolab.com:39267/nodejitsu_nko3-just-name-it-beansna_nodejitsudb5714439577')

app.get '/', (req, res) ->
  res.render 'index.jade'

server = app.listen(3000)
