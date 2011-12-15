Post = require('../models/post').Post

DashboardController =
  index: (req, res, next) ->
    Post.find {}, (err, posts) ->
      res.render 'dashboard/index'
        posts: posts

module.exports = DashboardController
