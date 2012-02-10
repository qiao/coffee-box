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
  }
