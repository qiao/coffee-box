RSS = require('rss')

exports.getPostsController = (app) ->

  POSTS_PER_PAGE = 5

  {Post}     = app.settings.models
  {postPath} = app.settings.helpers
  {markdown} = app.settings.utils

  return {

    # GET /posts
    index: (req, res, next) ->
      # check pagination param: /posts/?page=2
      pageNo = parseInt(req.query['page'], 10) or 1
      query = public: true, asPage: false
      Post.count query, (err, totalPosts) ->
        totalPages = Math.ceil(totalPosts / POSTS_PER_PAGE)
        options =
          skip:   (pageNo - 1) * POSTS_PER_PAGE
          limit:  POSTS_PER_PAGE
          sort:   [['createdAt', 'desc']]
        Post.find query, {}, options, (err, posts) ->
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
      post = new Post(req.body.post or {})
      post.content = markdown(post.rawContent or '')
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
          newPost = req.body.post or {}
          newPost.content = markdown(newPost.rawContent or '')
          newPost.createdAt = post.createdAt
          newPost.updatedAt = Date.now()
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
      Post.remove slug: req.params.slug, (err) ->
        res.redirect 'back'

    # find all posts published as individual pages
    # this is a middleware to apply before all requests
    findPages: (req, res, next) ->
      Post.find { asPage: true }, (err, pages) ->
        res.locals pages: pages
        next()

    # GET /:slug
    showPage: (req, res, next) ->
      Post.findOne { slug: req.params.slug }, (err, post) ->
        if post
          res.render 'posts/show'
            post: post
        else
          res.redirect '404'

    # GET /feed
    feed: (req, res, next) ->
      Post.find { public: true }, {}, { sort: [['createdAt', 'desc']] }, (err, posts) ->
        feed = new RSS
          title:       site.sitename
          description: site.description
          feed_url:    site.url + '/feed'
          author:      site.author

        for post in posts
          feed.item
            title:       post.title
            description: post.content
            url:         site.url + postPath(post)
            date:        post.createdAt

        res.send feed.xml()

    # POST /posts/preview
    preview: (req, res, next) ->
      try
        res.send markdown(req.body.rawContent), 200
      catch error
        res.send 400

  }
