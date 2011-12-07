Post = require('../models/post').model

PostsController =
  # GET /posts
  index: (req, res, next) ->
    Post.find {}, (err, posts) ->
      res.render 'posts/index'
        posts: posts
        title: 'Posts'

  # GET /posts/:slug
  show: (req, res, next) ->
    Post.findOne slug: req.params.slug, (err, post) ->
      if post
        res.render 'posts/show'
          post: post
          title: post.title
      else
        res.send 404
        #res.redirect '/404.html'

  # GET /posts/new
  new: (req, res, next) ->

  # GET /posts/:slug/edit
  edit: (req, res, next) ->

  # POST /posts
  create: (req, res, next) ->

  # PUT /posts
  update: (req, res, next) ->

  # DELETE /posts/:slug
  destroy: (req, res, next) ->

module.exports = PostsController
