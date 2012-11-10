# http://just-name-it-beansna.nko3.jit.su/

express = require('express')
controller = require('./controller')

app = express()
fs = require 'fs'
jsdom = require 'jsdom'

# scraped from http://memebase.cheezburger.com/senorgif
gifs = []

mongoose = require('mongoose')
mongoose.connect('mongodb://nodejitsu_nko3-just-name-it-beansna:22s0te0hc7ubqoimcjcnc17071@ds039267.mongolab.com:39267/nodejitsu_nko3-just-name-it-beansna_nodejitsudb5714439577')

process.nextTick ->
  offset = Math.floor(Math.random() * 50) + 1
  pages = 4
  for page in [offset..offset + pages]
    do(p=page)->
      jsdom.env "http://memebase.cheezburger.com/senorgif/page/#{p}",  ['http://code.jquery.com/jquery.js'], (err, window)->
        $ = window.$
        imgs = $('.event-item-lol-image').map (i, el) ->
          $(el).attr('src')
        console.log 'got page', p
        gifs.push.apply(gifs, imgs)

app.use express.static __dirname + '/public'

app.get '/', (req, res) ->
  res.render 'index.jade', {gifs: gifs}

server = app.listen(3000)
