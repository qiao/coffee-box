Post = require('../models/post').Post

DashboardController =
  index: (req, res, next) ->
    Post.find {}, {}, sort: [['createdAt', 'desc']], (err, posts) ->
      res.render 'dashboard/index'
        posts: posts

module.exports = DashboardController
