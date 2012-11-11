applicationSalt = "Marcus Sacco"

mongoose = require 'mongoose'
knox = require('knox')
Hashids = require("hashids")
hashids = new Hashids(applicationSalt, 5)

client = knox.createClient({
  key: 'AKIAJTQWG557XROA5WNA'
  secret: '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'
  bucket: 'nko-gifs'
})

mongoose.connect('mongodb://nodejitsu_nko3-just-name-it-beansna:22s0te0hc7ubqoimcjcnc17071@ds039267.mongolab.com:39267/nodejitsu_nko3-just-name-it-beansna_nodejitsudb5714439577')

GifSchema = new mongoose.Schema
  url: String
  slug: String

GifSchema.methods.link = ->
  "/gifs/#{ @slug }"

GifSchema.virtual('encodedData').get -> this.__encodedData
GifSchema.virtual('encodedData').set (val) -> this.__encodedData = val

GifSchema.methods.uploadAndSave = (callback) ->
  # Upload to S3
  data = new Buffer(@get('encodedData'), 'base64')
  slug = hashids.encrypt(randomNumber())

  req = client.put("/#{ slug }.gif", {
    'Content-Length': data.length
    'Content-Type': 'image/gif'
    'x-amz-acl': 'public-read'
  })

  req.on 'response', (res) =>
    if res.statusCode == 200
      @set('slug', slug)
      @set('url', req.url)
      @save(callback)
    else
      callback("Upload to s3 failed. Status code: #{ res.statusCode }", this)

  req.end(data)


randomNumber = ->
  Math.floor((Math.random()*10000000000000000)+1)




module.exports = mongoose.model('Gif', GifSchema)
