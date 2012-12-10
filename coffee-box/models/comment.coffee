mongoose = require 'mongoose'
Schema = mongoose.Schema

{markdown} = require('../lib/markdown')
{sanitize} = require('validator')

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
  read:
    type: Boolean
    required: true
    default: false
  createdAt:
    type: Date
    required: true
    default: Date.now
  updatedAt:
    type: Date
    required: true
    default: Date.now

CommentSchema.pre 'save', (next) ->
  markdown @rawContent, (html) =>
    @content   = sanitize(html).xss()
    @updatedAt = Date.now()
    next()

Comment = mongoose.model 'Comment', CommentSchema

module.exports =
  CommentSchema: CommentSchema
  Comment:       Comment
