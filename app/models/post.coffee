mongoose = require 'mongoose'
Schema = mongoose.Schema

CommentSchema = (require './comment').schema

PostSchema = new Schema
  title:     type: String, required: true
  body:      type: String
  comments:  [CommentSchema]
  tags:      [String]
  createdAt: type: Date,   required: true
  updatedAt: type: Date,   required: true

module.exports =
  schema: PostSchema
  model:  mongoose.model 'Post', PostSchema
