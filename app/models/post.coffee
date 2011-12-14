mongoose = require 'mongoose'
Schema = mongoose.Schema

CommentSchema = require('./comment').CommentSchema

PostSchema = new Schema
  title:
    type: String
    required: true
  content:
    type: String
  raw_content:
    type: String
  slug:
    type: String
    required: true
    unique: true
  comments:
    type: [CommentSchema]
  tags:
    type: [String]
  public:
    type: Boolean
    default: true
  asPage:
    type: Boolean
    default: false
  createdAt:
    type: Date
    required: true
    default: Date.now
  updatedAt:
    type: Date
    required: true
    default: Date.now

Post = mongoose.model 'Post', PostSchema

module.exports =
  PostSchema: PostSchema
  Post:       Post
