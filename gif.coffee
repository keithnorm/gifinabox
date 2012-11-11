mongoose = require 'mongoose'

mongoose.connect('mongodb://nodejitsu_nko3-just-name-it-beansna:22s0te0hc7ubqoimcjcnc17071@ds039267.mongolab.com:39267/nodejitsu_nko3-just-name-it-beansna_nodejitsudb5714439577')

GifSchema = new mongoose.Schema
  encodedData: String
  slug: String

GifSchema.methods.link = ->
  "/gifs/#{ @slug }"

module.exports = mongoose.model('Gif', GifSchema)
