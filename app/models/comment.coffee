mongoose = require 'mongoose'
Schema = mongoose.Schema

CommentSchema = new Schema
  author:    { type: String, required: true }
  email:     { type: String, required: true }
  website:   { type: String }
  content:   { type: String, required: true }
  createdAt: { type: Date,   required: true }
  updatedAt: { type: Date,   required: true }

Comment = mongoose.model 'Comment', CommentSchema

module.exports =
  schema: CommentSchema
  model:  Comment
