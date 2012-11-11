# http://just-name-it-beansna.nko3.jit.su/

applicationSalt = "Marcus Sacco"

express = require('express')
Hashids = require("hashids")
hashids = new Hashids(applicationSalt, 5)
knox = require('knox')

client = knox.createClient({
  key: 'AKIAJTQWG557XROA5WNA'
  secret: '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'
  bucket: 'nko-gifs'
})

Gif = require('./gif')

app = express()
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

  data = new Buffer(req.body.encodedData, 'base64')
  slug = hashids.encrypt(randomNumber())

  s3req = client.put("/#{ slug }.gif", {
    'Content-Length': data.length
    'Content-Type': 'image/gif'
    'x-amz-acl': 'public-read'
  })

  s3req.on 'response', (s3res) ->
    if res.statusCode == 200
      gif = new Gif(slug: slug, url: s3req.url)
      gif.save (err, gif) ->
        res.json gif

  s3req.end(data)


server = app.listen(3000)
