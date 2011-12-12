mongoose = require 'mongoose'
Schema = mongoose.Schema

CommentSchema = require('./comment').schema

PostSchema = new Schema
  title:     { type: String, required: true }
  content:   { type: String }
  slug:      { type: String, required: true }
  comments:  { type: [CommentSchema] }
  tags:      { type: [String] }
  createdAt: { type: Date,   required: true, default: Date.now }
  updatedAt: { type: Date,   required: true, default: Date.now }

Post = mongoose.model 'Post', PostSchema

module.exports =
  schema: PostSchema
  model:  Post
