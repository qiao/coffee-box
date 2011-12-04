mongoose = require 'mongoose'
Schema = mongoose.Schema

PostSchema = new Schema
  title:     type: String, required: true
  body:      type: String
  createdAt: type: Date,   required: true
  updatedAt: type: Date,   required: true

module.exports = mongoose.model 'Post', PostSchema
