mongoose = require 'mongoose'
Schema = mongoose.Schema

CommentSchema = new Schema
  author:    type: String, required: true
  email:     type: String, required: true
  url:       type: String
  body:      type: String, required: true
  createdAt: type: Date,   required: true
  updatedAt: type: Date,   required: true

module.exports = mongoose.model 'Comment', CommentSchema
