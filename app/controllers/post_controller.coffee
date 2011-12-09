Post = require('../models/post').model

POSTS_PER_PAGE = 5

PostsController =
  # GET /posts
  index: (req, res, next) ->
    # check pagination param: /posts/?page=2
    pageNo = parseInt(req.query['page'], 10) or 1
    Post.count (err, totalPosts) ->
      totalPages = Math.ceil(totalPosts / POSTS_PER_PAGE)
      options =
        skip:   (pageNo - 1) * POSTS_PER_PAGE
        limit:  POSTS_PER_PAGE
        sort:   [['createdAt', 'desc']]
      Post.find {}, {}, options, (err, posts) ->
        res.render 'posts/index'
          posts:      posts
          pageNo:     pageNo
          totalPages: totalPages


  # GET /posts/:slug
  show: (req, res, next) ->
    Post.findOne slug: req.params.slug, (err, post) ->
      if post
        res.render 'posts/show'
          post: post
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
