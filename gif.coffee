mongoose = require 'mongoose'

db = mongoose.createConnection('localhost', 'test')

GifSchema = new mongoose.Schema
  link: String
  encodedData: String

module.exports = db.model('Gif', GifSchema)
