mongoose = require 'mongoose'
Schema = mongoose.Schema

CommentSchema = new Schema
  author:
    type: String
    required: true
  email:
    type: String
    required: true
  website:
    type: String
  content:
    type: String
    required: true
  createdAt:
    type: Date
    required: true
    default: Date.now
  updatedAt:
    type: Date
    required: true
    default: Date.now

Comment = mongoose.model 'Comment', CommentSchema

module.exports =
  CommentSchema: CommentSchema
  Comment:       Comment
