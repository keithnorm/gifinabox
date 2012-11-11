# http://just-name-it-beansna.nko3.jit.su/

express = require('express')
controller = require('./controller')

Gif = require('./gif')

app = express()
fs = require 'fs'
jsdom = require 'jsdom'

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

app.use express.static __dirname + '/public'

app.get '/', (req, res) ->
  res.render 'index.jade', {gifs: gifArray}

app.get '/show/:id', (req, res) ->
  Gif.findOne(_id: req.params.id).exec (err, gif) ->
    res.render 'show.jade', {gif: gif}

app.post '/gif', (req, res) ->
  gif = new Gif
    encodedData: req.params.encodedData
    link: req.params.link

  gif.save (err, gif) ->
    res.render 'show.jade', {gifs: gifArray}

server = app.listen(3000)
