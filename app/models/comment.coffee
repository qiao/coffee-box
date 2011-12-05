mongoose = require 'mongoose'
Schema = mongoose.Schema

CommentSchema = new Schema
  author:    type: String, required: true
  email:     type: String, required: true
  website:   type: String
  body:      type: String, required: true
  createdAt: type: Date,   required: true
  updatedAt: type: Date,   required: true

module.exports =
  schema: CommentSchema
  model:  mongoose.model 'Comment', CommentSchema
