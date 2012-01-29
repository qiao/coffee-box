mongoose = require 'mongoose'
Schema = mongoose.Schema

{markdown} = require('../../lib/markdown')
{makeTagList} = require('../../lib/taglist')

{CommentSchema} = require('./comment')

PostSchema = new Schema
  title:
    type: String
    required: true
  content:
    type: String
  rawContent:
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

PostSchema.pre 'save', (next) ->
  @tags = makeTagList @tags[0]
  markdown @rawContent, (html) =>
    @content   = html
    @updatedAt = Date.now()
    next()

PostSchema.statics.countPosts = (callback) ->
  query =
    public: true
    asPage: false
  @count query, callback

PostSchema.statics.countPostPages = (postsPerPage, callback) ->
  @countPosts (err, count) ->
    return callback err, null if err?
    callback null, Math.ceil(count / postsPerPage)

PostSchema.statics.getPostsOfPage = (pageNo, postsPerPage, callback) ->
  @countPostPages postsPerPage, (err, count) =>
    return callback err, null if err?
    query =
      public: true
      asPage: false
    options =
      skip:   (pageNo - 1) * postsPerPage
      limit:  postsPerPage
      sort:   [['createdAt', 'desc']]
    @find query, {}, options, callback

PostSchema.statics.findPages = (callback) ->
  query =
    public: true
    asPage: true
  @find query, callback

PostSchema.statics.findPosts = (callback) ->
  query =
    public: true
    asPage: false
  @find query, callback

PostSchema.statics.findBySlug = (slug, callback) ->
  query = slug: slug
  @findOne query, callback

PostSchema.statics.removeBySlug = (slug, callback) ->
  query = slug: slug
  @remove query, callback

Post = mongoose.model 'Post', PostSchema

module.exports =
  PostSchema: PostSchema
  Post:       Post
