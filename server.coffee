# http://just-name-it-beansna.nko3.jit.su/

applicationSalt = "Marcus Sacco"

express = require('express')
controller = require('./controller')
Hashids = require("hashids")
hashids = new Hashids(applicationSalt, 5)

Gif = require('./gif')

app = express()
fs = require 'fs'
jsdom = require 'jsdom'

app.use(express.bodyParser())

randomNumber = ->
  Math.floor((Math.random()*10000000000000000)+1)

app.use express.static __dirname + '/public'

app.get '/', (req, res) ->
  Gif.find().limit(8).sort({ '$natural': -1 }).exec (err, gifs) =>
    res.render 'index.jade', { gifs: gifs }

app.get '/gifs/:slug', (req, res) ->
  Gif.findOne(slug: req.params.slug).exec (err, gif) ->
    res.render 'show.jade', { gif: gif }

app.post '/gifs', (req, res) ->
  gif = new Gif
    slug: hashids.encrypt(randomNumber())
    encodedData: req.body.encodedData

  gif.save (err, gif) ->
    res.json { slug: gif.get('slug') }

server = app.listen(3000)
