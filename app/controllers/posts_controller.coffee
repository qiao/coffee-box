exports.getPostsController = (app) ->

  RSS                     = require('rss')
  {Post}                  = app.settings.models
  {postPath}              = app.settings.helpers
  {markdown, makeTagList} = app.settings.utils

  return {

    # GET /posts
    index: (req, res, next) ->
      # check pagination param: /posts/?page=2
      pageNo = parseInt(req.query['page'], 10) or 1

      POSTS_PER_PAGE = 5
      Post.countPostPages POSTS_PER_PAGE, (err, totalPages) ->
        Post.getPostsOfPage pageNo, POSTS_PER_PAGE, (err, posts) ->
          return res.redirect '500' if err?
          res.render 'posts/index'
            posts:      posts
            pageNo:     pageNo
            totalPages: totalPages

    # GET /year/month/day/:slug.:format?
    show: (req, res, next) ->
      Post.findBySlug req.params.slug, (err, post) ->
        return res.redirect '500' if err?
        return res.redirect '404' unless post?
        res.render 'posts/show'
          post: post

    # GET /posts/new
    new: (req, res, next) ->
      res.render 'posts/new'
        post: new Post

    # GET /year/month/day/:slug/edit
    edit: (req, res, next) ->
      Post.findBySlug req.params.slug, (err, post) ->
        return res.redirect '500' if err?
        return res.redirect '404' unless post?
        res.render 'posts/edit'
          post: post

    # POST /posts
    create: (req, res, next) ->
      params       = req.body.post
      post         = new Post params
      post.taglist = params.tags
      post.save (err) ->
        if err
          req.flash 'error', err
          res.redirect 'back'
        else
          req.flash 'info', 'successfully posted'
          res.redirect postPath(post)

    # PUT /year/month/day/:slug
    update: (req, res, next) ->
      Post.findBySlug req.params.slug, (err, post) ->
        return res.redirect '500' if err?
        return res.redirect '404' unless post?
        params          = req.body.post
        post.title      = params.title
        post.rawContent = params.rawContent
        post.slug       = params.slug
        post.taglist    = params.tags
        post.save (err) ->
          if err
            req.flash 'error', err
            res.redirect 'back'
          else
            req.flash 'info', 'successfully updated'
            res.redirect postPath(post)

    # DELETE /year/month/day/:slug
    destroy: (req, res, next) ->
      Post.removeBySlug req.params.slug, (err) ->
        res.redirect 'back'

    # find all posts published as individual pages
    # this is a middleware to apply before all requests
    findPages: (req, res, next) ->
      Post.findPages (err, pages) ->
        res.locals pages: pages
        next()

    # GET /:slug
    showPage: (req, res, next) ->
      Post.findBySlug req.params.slug, (err, post) ->
        return res.redirect '500' if err?
        return res.redirect '404' unless post?
        res.render 'posts/show'
          post: post

    # GET /feed
    feed: (req, res, next) ->
      Post.findPosts (err, posts) ->
        feed = new RSS
          title:       app.settings.sitename
          description: app.settings.description
          feed_url:    app.settings.url + '/feed'
          author:      app.settings.author

        for post in posts
          feed.item
            title:       post.title
            description: post.content
            url:         app.settings.url + postPath(post)
            date:        post.createdAt

        res.send feed.xml()

    # POST /posts/preview
    preview: (req, res, next) ->
      markdown req.body.rawContent or '', (html) ->
        res.send html, 200

  }
