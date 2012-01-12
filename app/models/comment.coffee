mongoose = require 'mongoose'
Schema = mongoose.Schema

CommentSchema = new Schema
  name:
    type: String
    required: true
  email:
    type: String
    required: true
  website:
    type: String
  rawContent:
    type: String
    required: true
  content:
    type: String
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
