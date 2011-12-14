Post     = require('../models/post').model
postPath = require('../helpers/posts_helper').postPath
markdown = require('../../lib/markdown').Markdown

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
    post = new Post req.body.post
    post.content = markdown post.raw_content
    post.save (err) ->
      if err
        req.flash 'error', err
        res.redirect 'back'
      else
        req.flash 'info', 'successfully posted'
        res.redirect postPath(post)

  # PUT /year/month/day/:slug
  update: (req, res, next) ->
    query = slug: req.params.slug
    Post.findOne query, (err, post) ->
      if post
        newPost = req.body.post
        newPost.content = markdown newPost.raw_content
        newPost.createdAt = post.createdAt
        Post.update query, newPost, (err) ->
          if err
            req.flash 'error', err
            res.redirect 'back'
          else
            req.flash 'info', 'successfully updated'
            res.redirect postPath(newPost)
      else
        res.redirect '404'

  # DELETE /year/month/day/:slug
  destroy: (req, res, next) ->
    Post.remove slug: req.params.slug

module.exports = PostsController
