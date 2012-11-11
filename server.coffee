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

# scraped from http://memebase.cheezburger.com/senorgif
gifArray = []

process.nextTick ->
  offset = Math.floor(Math.random() * 50) + 1
  pages = 2
  for page in [offset..offset + pages]
    do(p=page)->
      jsdom.env "http://memebase.cheezburger.com/senorgif/page/#{p}",  ['http://code.jquery.com/jquery.js'], (err, window)->
        $ = window.$
        imgs = $('.event-item-lol-image').map (i, el) ->
          $(el).attr('src')
        gifArray.push.apply(gifArray, imgs)

randomNumber = ->
  Math.floor((Math.random()*10000000000000000)+1)

app.use express.static __dirname + '/public'

app.get '/', (req, res) ->
  res.render 'index.jade', {gifs: gifArray}

app.get '/gifs/:slug', (req, res) ->
  Gif.findOne(slug: req.params.slug).exec (err, gif) ->
    res.render 'show.jade', {gif: gif}

app.post '/gifs', (req, res) ->

  gif = new Gif
    slug: hashids.encrypt(randomNumber())
    encodedData: req.body.encodedData

  gif.save (err, gif) ->
    res.json { slug: gif.get('slug') }

server = app.listen(3000)
