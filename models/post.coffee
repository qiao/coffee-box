mongoose = require 'mongoose'
Schema = mongoose.Schema

PostSchema = new Schema
  title:
    type: String
    required: true
  body:
    type: String
  createdAt:
    type: String
    required: true
  updatedAt:
    type: String
    required: true

module.exports = mongoose.model 'Post', PostSchema
