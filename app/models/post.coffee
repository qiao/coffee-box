mongoose = require 'mongoose'
Schema = mongoose.Schema

CommentSchema = (require './comment').schema

PostSchema = new Schema
  title:     { type: String, required: true }
  body:      { type: String }
  slug:      { type: String, required: true }
  comments:  [CommentSchema]
  tags:      [String]
  createdAt: { type: Date,   required: true }
  updatedAt: { type: Date,   required: true }

Post = mongoose.model 'Post', PostSchema

#(new Post title: 'hello', body: 'world', slug: '123', createdAt: new Date, updatedAt: new Date).save()
#(new Post title: 'foo', body: 'bar', slug: '234', createdAt: new Date, updatedAt: new Date).save()
#(new Post title: 'asdf', body: 'zxcv', slug: '235', createdAt: new Date, updatedAt: new Date).save()
  

module.exports =
  schema: PostSchema
  model:  Post
