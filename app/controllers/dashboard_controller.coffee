Post = require('../models/post').Post

module.exports = DashboardController =
  index: (req, res, next) ->
    Post.find {}, {}, sort: [['createdAt', 'desc']], (err, posts) ->
      res.render 'dashboard/index'
        posts: posts
        newPost: new Post
