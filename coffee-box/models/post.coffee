async    = require 'async'
mongoose = require 'mongoose'
Schema   = mongoose.Schema
moment   = require 'moment'
{markdown} = require('../lib/markdown')
{makeTagList} = require('../lib/taglist')

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
    index: true
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
  markdown @rawContent, (html) =>
    @content   = html
    @updatedAt = Date.now()
    next()

PostSchema
  .virtual('data')
  .set (data) ->
    @[k] = v for k, v of data
    @tags = makeTagList data.tags

PostSchema.virtual('path').get ->"/#{moment(@createdAt).format 'YYYY/MM/DD'}/#{@slug}"
PostSchema.virtual('day').get ->moment(@createdAt).format 'DD'
PostSchema.virtual('month').get ->moment(@createdAt).format 'MMM'
PostSchema.virtual('commentsAnchor').get ->"#comments-#{@_id}"

PostSchema.set 'toJSON'
  getters     : true
  virtuals    : true

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

PostSchema.statics.findAll = (callback) ->
  options = sort: [['createdAt', 'desc']]
  @find {}, {}, options, callback

PostSchema.statics.findBySlug = (slug, callback) ->
  query = slug: slug
  @findOne query, callback

PostSchema.statics.removeBySlug = (slug, callback) ->
  query = slug: slug
  @remove query, callback

# XXX: This static method is really ugly.
PostSchema.statics.findUnreadComments = (callback) ->
  @find { 'comments.read': false }, (err, posts) ->
    return callback err, null if err
    comments = []
    posts.forEach (post) ->
      post.comments.forEach (comment) ->
        unless comment.read
          comment.post = post
          comments.push comment
    comments.sort (a, b) ->
      b.createdAt.getTime() - a.createdAt.getTime()
    callback null, comments

PostSchema.statics.markAllAsRead = (callback) ->
  @find { 'comments.read': false }, (err, posts) ->
    return callback err if err
    update = (post, done) ->
      post.comments.forEach (comment) ->
        comment.read = true
      post.save (err) ->
        done()
    async.forEach posts, update, callback

Post = mongoose.model 'Post', PostSchema

module.exports =
  PostSchema: PostSchema
  Post:       Post
