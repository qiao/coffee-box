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


  # GET /year/month/day/:slug.:format?
  show: (req, res, next) ->
    Post.findOne slug: req.params.slug, (err, post) ->
      if post
        res.render 'posts/show'
          post: post
      else
        res.redirect '404'

  # GET /posts/new
  new: (req, res, next) ->
    res.render 'posts/new'
      post: new Post

  # GET /year/month/day/:slug/edit
  edit: (req, res, next) ->
    Post.findOne slug: req.params.slug, (err, post) ->
      if post
        res.render 'posts/edit'
          post: post
      else
        res.redirect '404'

  # POST /posts
  create: (req, res, next) ->

  # PUT /year/month/day/:slug
  update: (req, res, next) ->

  # DELETE /year/month/day/:slug
  destroy: (req, res, next) ->

module.exports = PostsController
