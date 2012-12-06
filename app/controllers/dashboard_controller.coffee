exports.getDashboardController = (app) ->

  {Post} = app.settings.models

  return {

    index: (req, res, next) ->
      Post.findAll (err, posts) ->
        Post.findUnreadComments (err, comments) ->
          res.render 'dashboard/index'
            posts: posts
            newPost: new Post
            comments: comments
            dashboardEntry: 'index'
    posts: (req, res, next) ->
      Post.findAll (err, posts) ->
        res.render 'dashboard/posts'
          posts: posts
          dashboardEntry: 'posts'
    comments: (req, res, next) ->
      Post.findUnreadComments (err, comments) ->
        res.render 'dashboard/comments'
          comments: comments
          dashboardEntry: 'comments'
    newPost: (req, res, next) ->
      res.render 'dashboard/new-post'
        newPost: new Post
        dashboardEntry: 'new-post'
    config: (req, res, next) ->
      res.render 'dashboard/config'
        dashboardEntry: 'config'

  }
