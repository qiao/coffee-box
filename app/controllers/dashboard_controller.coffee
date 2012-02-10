exports.getDashboardController = (app) ->

  {Post, Comment} = app.settings.models

  return {

    index: (req, res, next) ->
      Post.findAll (err, posts) ->
        Comment.findUnread (err, comments) ->
          console.log comments
          res.render 'dashboard/index'
            posts: posts
            newPost: new Post
            comments: comments
  }
