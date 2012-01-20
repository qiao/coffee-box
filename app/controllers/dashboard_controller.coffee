exports.DashboardController = (app) ->

  {Post} = app.settings.models

  return {

    index: (req, res, next) ->
      Post.find {}, {}, sort: [['createdAt', 'desc']], (err, posts) ->
        res.render 'dashboard/index'
          posts: posts
          newPost: new Post

  }
