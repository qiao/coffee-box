mongoose    = require 'mongoose'
Schema      = mongoose.Schema
gravatar    = require 'gravatar'
moment      = require 'moment'

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

CommentSchema.virtual('anchor').get -> "#{@_id}"
CommentSchema.virtual('gravatarUrl').get -> gravatar.url @email, size: '32', default: 'mm'
CommentSchema.path('website').get (website)-> if /^https?:\/\//.test website then website else "http://#{website}"
CommentSchema.virtual('meta').get -> moment(@createdAt).format 'YYYY-MM-DD hh:mm'

CommentSchema.set 'toJSON',
  getters       : true
  virtuals      : true


Comment = mongoose.model 'Comment', CommentSchema

module.exports =
  CommentSchema: CommentSchema
  Comment:       Comment
