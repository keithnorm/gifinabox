# http://just-name-it-beansna.nko3.jit.su/

express = require('express')

Gif = require('./gif')

app = express()
app.use(express.bodyParser())

app.use express.static __dirname + '/public'

app.get '/', (req, res) ->
  Gif.find().limit(30).sort({ _id : -1 }).exec (err, gifs) =>
    res.render 'index.jade', { gifs: gifs }

app.get '/gifs/:slug', (req, res) ->
  Gif.findOne(slug: req.params.slug).exec (err, gif) ->
    res.render 'show.jade', { gif: gif }

app.post '/gifs', (req, res) ->
  gif = new Gif(encodedData: req.body.encodedData)
  gif.uploadAndSave (err, gif) ->
    res.json gif


server = app.listen(3000)
